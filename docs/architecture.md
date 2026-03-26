# Architecture Notes

## Backend

- Rails controllers stay thin and focus on HTTP concerns.
- `Pundit` handles role-based authorization.
- `Borrowings::Create` and `Borrowings::ReturnBook` isolate the business rules that are easiest to discuss during code review.
- The `Book` model exposes availability behavior and search logic.
- The `Borrowing` model owns active, overdue, and due-today scopes.

## Data Integrity

- `books.isbn` is unique.
- `books.total_copies` has a positive check constraint.
- `borrowings` has a partial unique index on `user_id + book_id` for active borrowings only.
- Borrowing creation locks the selected book row before checking availability.

## Frontend

- The React app lives in `frontend/` and talks to Rails through the `/api/v1` endpoints.
- The UI keeps state close to the page because the exercise is small and clarity matters more than abstraction.
- Vite proxies `/api` requests to Rails in development, so local integration is straightforward.

## Tradeoffs

- Public sign-up is limited to members. Librarians are provisioned through seeds because open librarian registration would not be appropriate in a real system.
- The frontend is intentionally compact. It covers the required flows without introducing extra client-side complexity.
