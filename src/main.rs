use crate::config::AppConfig;
use actix_web::{web, App, HttpResponse, HttpServer, Responder};
use dotenv::dotenv;
use env_logger::Env;
use log::{error, info};
use rusoto_core::{HttpClient, Region};
use rusoto_credential::EnvironmentProvider;
use rusoto_s3::{PutObjectRequest, S3Client, S3};
use std::env;
use std::str::FromStr;
use std::sync::Arc;

mod config;

async fn health() -> impl Responder {
    HttpResponse::Ok().body("Healthy")
}

async fn record(
    data: web::Json<String>,
    s3_client: web::Data<Arc<S3Client>>,
    config: web::Data<AppConfig>,
) -> impl Responder {
    let put_request = PutObjectRequest {
        bucket: config.aws_s3_bucket.clone(),
        key: "example.txt".to_string(),
        body: Some(data.into_inner().into_bytes().into()),
        ..Default::default()
    };

    match s3_client.put_object(put_request).await {
        Ok(_) => {
            info!("Data successfully written to S3");
            HttpResponse::Ok().body("Data written to S3")
        }
        Err(e) => {
            error!("Error writing to S3: {}", e);
            HttpResponse::InternalServerError().body(format!("Failed: {}", e))
        }
    }
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    dotenv().ok();
    env_logger::Builder::from_env(Env::default().default_filter_or("info")).init();

    let aws_region = env::var("AWS_REGION").expect("AWS_REGION not set");
    let config = AppConfig::new().expect("Failed to load configuration");
    let region = Region::from_str(&aws_region).expect("Invalid AWS region provided");

    let s3_client = Arc::new(S3Client::new_with(
        HttpClient::new().expect("Failed to create HTTP client"),
        EnvironmentProvider::default(),
        region,
    ));

    HttpServer::new(move || {
        App::new()
            .app_data(web::Data::new(s3_client.clone()))
            .app_data(web::Data::new(config.clone()))
            .route("/health", web::get().to(health))
            .route("/record", web::post().to(record))
    })
    .bind("0.0.0.0:8080")?
    .run()
    .await
}
