# SQL Database Project

A PostgreSQL project demonstrating relational schema design, data integrity constraints, and analytical querying across two datasets: a vehicle ownership registry and a product orders system.

---

## Project Structure

The project works across two schemas:

**`mt2` — Vehicle Ownership Registry**
Models the relationship between vehicle owners and their registered automobiles, with constraints enforcing data integrity at the schema level.

**`cap` — Product Orders System**
A pre-existing schema used for analytical queries joining customers, orders, and products.

---

## Schema Design

### `tbl_owners`
Stores vehicle owner records.

| Column | Type | Description |
|---|---|---|
| `SSN` | CHAR(9) | Primary key |
| `f_name` | VARCHAR(50) | First name (NOT NULL) |
| `m_initial` | VARCHAR(1) | Middle initial (optional) |
| `l_name` | VARCHAR(50) | Last name (NOT NULL) |
| `address` | VARCHAR(100) | Street address (NOT NULL) |
| `city` | VARCHAR(50) | City (NOT NULL) |
| `state` | CHAR(2) | State abbreviation (NOT NULL) |
| `phone` | VARCHAR(20) | Phone number (NOT NULL) |
| `dob` | DATE | Date of birth (NOT NULL) |

### `tbl_autos`
Stores registered vehicle records linked to owners.

| Column | Type | Description |
|---|---|---|
| `VIN` | CHAR(256) | Primary key |
| `make` | VARCHAR(30) | Vehicle make (NOT NULL) |
| `model` | VARCHAR(30) | Vehicle model (NOT NULL) |
| `color` | VARCHAR(3) | Color code — see allowed values below |
| `owner_SSN` | CHAR(9) | Foreign key → `tbl_owners.SSN` (NOT NULL) |

**Allowed color codes:**

| Code | Color | Code | Color |
|---|---|---|---|
| BLU | Blue | GRY | Gray |
| MAR | Maroon | PNK | Pink |
| YEL | Yellow | TAN | Tan |
| SIL | Silver | BRO | Brown |
| PLE | Purple | BLK | Black |
| ONG | Orange | RED | Red |
| GRN | Green | GLD | Gold |
| BGE | Beige | WHI | White |

---

## Sample Data

**Owners**

| SSN | Name | City | State |
|---|---|---|---|
| 7722 | Al B. Jones | Denton | TX |
| 9805 | Bob A. Roberts | Denton | TX |
| 3426 | Connie G. Smith | Plano | TX |
| 9871 | Dale O. Evans | Dallas | TX |

**Autos**

| VIN | Make | Model | Color | Owner SSN |
|---|---|---|---|---|
| 7635 | Ford | Ranger | RED | 9805 |
| 76A3 | Toyota | Corolla | TAN | 9805 |
| 2B9X | Ford | Mustang | BLK | 9871 |
| 5301 | VW | Golf | GRN | 3426 |

---

## Queries

### `cap` Schema — Orders Analysis

**Customers who ordered product `p02`**
Joins `tblorders` and `tblcustomers` to return customer names and IDs for a specific product.

**Customers who ordered a brush**
Extends the previous join with `tblproducts` to filter by product name rather than ID.

**Total orders for product `p05`**
Uses `COUNT(*)` and `GROUP BY` to return the order volume for a specific product.

**Total pencil orders**
Counts all orders where the product name is `pencil`.

**Pencil orders by month**
Breaks down pencil order counts by `o_month` to show demand over time.

**Product with the highest quantity in stock**
Uses a correlated subquery with `MAX(quantity)` to return the top-stocked product.

### `mt2` Schema — Owners Without Vehicles

**Owners with no registered vehicle**
Uses a `LEFT OUTER JOIN` between `tbl_owners` and `tbl_autos`, filtering for rows where no matching auto exists. Returns the SSN and full name of unregistered owners.

---

## Concepts Demonstrated

- Schema creation and search path management
- Primary and foreign key constraints
- `CHECK` constraints for null enforcement and value validation
- Normalized relational modeling
- `INNER JOIN` and `LEFT OUTER JOIN`
- Aggregate functions (`COUNT`, `MAX`)
- Subqueries
- Grouping and filtering with `GROUP BY` and `WHERE`

---

## How to Run

1. Connect to a PostgreSQL instance
2. Run the full script to create the `mt2` schema, tables, and sample data
3. Ensure the `cap` schema with `tblorders`, `tblcustomers`, and `tblproducts` exists before running the `cap` queries
4. Execute queries individually or as a batch

```bash
psql -U your_username -d your_database -f project.sql
```
