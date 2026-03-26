function LibrarianBorrowingsPanel({ borrowings, onReturn }) {
  const activeBorrowings = borrowings.filter((borrowing) => borrowing.active);
  const returnedBorrowings = borrowings.filter((borrowing) => !borrowing.active);

  function renderBorrowingItem(borrowing, showReturnAction = false) {
    return (
      <li key={borrowing.id}>
        <div className="borrowing-summary">
          <strong>
            {borrowing.book?.title}
            {borrowing.overdue && <span className="overdue-badge">Overdue</span>}
          </strong>
          <div className="borrowing-meta">
            <span>
              <small>Member</small>
              {borrowing.user?.full_name}
            </span>
            <span>
              <small>Due date</small>
              {borrowing.due_on}
            </span>
            {!showReturnAction && borrowing.returned_at && (
              <span>
                <small>Returned at</small>
                {borrowing.returned_at}
              </span>
            )}
          </div>
        </div>
        {showReturnAction && <button onClick={() => onReturn(borrowing.id)}>Mark as returned</button>}
      </li>
    );
  }

  return (
    <section className="panel">
      <h2>Borrowings</h2>

      <div className="borrowings-group">
        <h3>Active borrowings</h3>
        {activeBorrowings.length > 0 ? (
          <ul className="simple-list borrowings-list">
            {activeBorrowings.map((borrowing) => renderBorrowingItem(borrowing, true))}
          </ul>
        ) : (
          <p className="muted-copy">There are no active borrowings right now.</p>
        )}
      </div>

      <div className="borrowings-group">
        <h3>Returned borrowings</h3>
        {returnedBorrowings.length > 0 ? (
          <ul className="simple-list borrowings-list">
            {returnedBorrowings.map((borrowing) => renderBorrowingItem(borrowing))}
          </ul>
        ) : (
          <p className="muted-copy">There are no returned borrowings yet.</p>
        )}
      </div>
    </section>
  );
}

export default LibrarianBorrowingsPanel;
