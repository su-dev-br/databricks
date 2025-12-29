databricks-bundle-repo/
├── shared
│   ├── variables.yml           # has variable definitions like cluster_id
│   └── shared_library.py       # has shared code used in multiple bundles
├── job_bundle
│   ├── databricks.yml          # uses ${var.cluster_id} defined in variables.yml
│   ├── resources/
│   │   └── job_bundle.job.yml
│   ├── src/
│   │   ├── notebook.ipynb
│   │   └── my_python.py        # uses ../shared/shared_library.py
│   └── README.md
├── pipeline_bundle
│   ├── databricks.yml
│   ├── resources/
│   │   ├── pipeline_bundle.job.yml      # uses ${var.cluster_id} defined in variables.yml
│   │   └── pipeline_bundle.pipeline.yml
│   ├── src/
│   │   └── my_pipeline.ipynb
│   └── README.md



https://docs.databricks.com/aws/en/dev-tools/bundles/sharing