# resources/__init__.py

from databricks.bundles.core import (
    Bundle,
    Resources,
    load_resources_from_current_package_module,
)



from databricks.bundles.jobs import Job


def create_job(country: str):
    my_notebook = {
        "task_key": "my_notebook",
        "notebook_task": {
            "notebook_path": "files/my_notebook.py",
        },
    }


    return Job.from_dict(
        {
            "name": f"my_job_{country}",
            "tasks": [my_notebook],
        }
    )


def load_resources(bundle: Bundle) -> Resources:
    resources = load_resources_from_current_package_module()


    for country in ["US", "NL"]:
        resources.add_resource(f"my_job_{country}", create_job(country))


    return resources