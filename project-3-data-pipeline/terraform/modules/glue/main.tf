locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

resource "aws_glue_catalog_database" "this" {
  name = replace("${local.name_prefix}_db", "-", "_")
}

resource "aws_glue_catalog_table" "processed_events" {
  name          = "processed_events"
  database_name = aws_glue_catalog_database.this.name
  table_type    = "EXTERNAL_TABLE"

  parameters = {
    EXTERNAL = "TRUE"
  }

  storage_descriptor {
    location      = "s3://${var.processed_bucket_name}/processed/"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    ser_de_info {
      name                  = "json"
      serialization_library = "org.openx.data.jsonserde.JsonSerDe"
    }

    columns {
      name = "user_id"
      type = "int"
    }

    columns {
      name = "event_type"
      type = "string"
    }

    columns {
      name = "country"
      type = "string"
    }

    columns {
      name = "timestamp"
      type = "string"
    }

    columns {
      name = "processed_at"
      type = "string"
    }

    columns {
      name = "is_purchase"
      type = "boolean"
    }
  }
}
