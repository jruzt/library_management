# GenAI Notes

## Prompt I Would Use

Create a Rails API for a task management system.

Requirements:
- Rails 7+
- PostgreSQL
- `Task` belongs to `User`
- Task fields: `title`, `description`, `status`, `due_date`
- Build CRUD endpoints under `/api/v1/tasks`
- Add model validations
- Return JSON with correct status codes
- Add request specs with RSpec
- Keep controllers thin and move business logic out when appropriate

## Representative AI-Generated Sample

```ruby
class Api::V1::TasksController < ApplicationController
  before_action :set_task, only: %i[show update destroy]

  def index
    render json: current_user.tasks.order(:due_date)
  end

  def create
    task = current_user.tasks.new(task_params)

    if task.save
      render json: task, status: :created
    else
      render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :status, :due_date)
  end
end
```

## How I Would Validate It

- Run request specs for create, update, delete, authorization, and invalid params.
- Check that tasks are scoped to the current user.
- Confirm status values are validated and not free-form.
- Review for strong parameters, proper status codes, and missing indexes.

## Typical Improvements I Would Make

- Add a DB index on `user_id` and any filtered columns.
- Replace overly generic JSON rendering with a clear response shape.
- Extract business rules if task transitions become more complex.
- Add authentication and authorization checks if the generated code assumes `current_user` already exists.

## What I Look For In AI Output

- Correctness first
- Idiomatic Rails conventions
- Clear ownership of business rules
- Thin controllers
- Defensive validation at both app and DB level when needed
