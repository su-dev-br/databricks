# databricks bundle init pydabs

from databricks.bundles.jobs import Job
from databricks.bundles.jobs import Job, Task, NotebookTask


my_pydabs_project_job = Job.from_dict(
    {
        "name": "my_pydabs_project_job",
        "tasks": [
            {
                "task_key": "notebook_task",
                "notebook_task": {
                    "notebook_path": "src/notebook.ipynb",
                },
            },
        ],
    },
)


my_pydabs_project_job = Job(
    name="my_pydabs_project_job",
    tasks=[
        Task(
            task_key="notebook_task",
            notebook_task=NotebookTask(
                notebook_path="src/notebook.ipynb",
            ),
        ),
    ],
)