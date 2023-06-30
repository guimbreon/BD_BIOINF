# Trabalho_BD

This repository contains the database project for an organization responsible for travel requests and expense reimbursement. The objective is to manage travel requests made by applicants, storing relevant information about the applicants, organizational units, travel requests, attached documents, approvals, expenses, funding, meals, and approvals.

## Supporting Documents:

In the file [Support_Docs](Support_Docs), we have the supporting documents used to prepare the project.


## Database Structure

Below is the list of entities present in the database schema:

1. Sponsor:
   - Sponsor_ID (INT)
   - Internal (VARCHAR(5))
   - Sponsor (VARCHAR(100))

2. Itinerary:
   - Itinerary_ID (INT)
   - Travel_Destinations (VARCHAR(150))

3. Responsible:
   - Responsible_ID (INT)
   - Name (VARCHAR(150))
   - Position (VARCHAR(150))

4. Travel_Request_Status:
   - Status_ID (INT)
   - Status (VARCHAR(150))
   - Responsible_ID (INT) (foreign key referencing the Responsible table)
   - Status_Date (DATE)

5. Document:
   - Attachment_ID (INT)
   - File_Name (VARCHAR(100))
   - File_Attachment (VARCHAR(100))

6. Funding:
   - Funding_ID (INT)
   - Meal (INT)
   - Transportation (INT)
   - Registration (INT)
   - Total_Expenses (INT)
   - Sponsor_ID (INT) (foreign key referencing the Sponsor table)

7. Expense_Request:
   - Expense_Request_ID (INT)
   - Request_Date (DATE)
   - Funding_ID (INT) (foreign key referencing the Funding table)

8. Travel_Request:
   - Travel_Request_ID (INT)
   - Request_Date (DATE)
   - Departure_Date (DATE)
   - Return_Date (DATE)
   - Itinerary_ID (INT) (foreign key referencing the Itinerary table)
   - Reason (VARCHAR(150))
   - Status_ID (INT) (foreign key referencing the Travel_Request_Status table)
   - Attachment_ID (INT) (foreign key referencing the Document table)
   - Expense_Request_ID (INT) (foreign key referencing the Expense_Request table)

9. Approval:
   - Approval_ID (INT)
   - Travel_Request_ID (INT) (foreign key referencing the Travel_Request table)
   - Approval_Date (DATE)
   - Comment (VARCHAR(200))

10. Applicant:
    - Applicant_ID (INT)
    - Name (VARCHAR(50))
    - Category (VARCHAR(50))
    - Travel_Request_ID (INT) (foreign key referencing the Travel_Request table)

These entities represent the main elements of the company's travel request and expense reimbursement management system.

## Other Work Elements:

Views, Triggers, and Stored Procedures were also created for the database tables.

##README.md in Portuguese
[README.md](../Readme.md)

## License

This project is licensed under the terms of the [License](LICENSE).
