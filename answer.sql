Audit Logging with Triggers & JSONB
What it does: Creates an audit_log table and a generic trigger function (audit()) that captures data modifications (INSERT, UPDATE, DELETE) on a table (like students) and serializes the old and new rows into JSONB.

Why use JSONB? Unlike structured relational columns, JSONB provides schema flexibility. If your students table adds or removes columns later, the audit log doesn't break or require table alterations; it simply stores whatever state existed at that moment.

Key nuance: In INSERT operations, OLD is null; in DELETE operations, NEW is null. The COALESCE(NEW, OLD) return statement ensures the trigger correctly passes the row through to the database operation.

2. Inspecting the Audit Trail
What it does: Demonstrates how to query the stored JSON data using JSON operators (->> extracts text fields) to compare what a value was versus what it is now.

3. Modeling a Category Tree (Recursive CTEs)
What it does: Implements an adjacency list model (categories with a self-referencing parent_id) and queries it hierarchically using a WITH RECURSIVE Common Table Expression.

How it works:

The anchor member finds root nodes (parent_id IS NULL).

The recursive member joins the categories table back onto the tree CTE to find children, incrementing the depth counter each level down.

4. Versioned Migrations with Flyway
What it does: Establishes a formal convention for database schema evolution (V1__..., V2__...).

Why it matters: In production environments, schema changes should never be applied manually. Flyway tracks which migration scripts have already been run in a metadata table, 
ensuring consistency across local, staging, and production environments.

5. Least-Privilege Security
What it does: Enforces the principle of least privilege by separating database access into logical roles (app_read and app_write) and granting explicit, 
minimal permissions rather than handing out superuser access.

Security benefit: If an application API user (api) is compromised, the blast radius is restricted to only 
the permissions explicitly granted to app_write (and prevents unauthorized DDL or administrative drops).