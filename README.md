# Many-to-Many Relationship in Snowflake Semantic Views (Bridge Table Pattern)

Snowflake semantic views do not support many-to-many relationships directly. This repo demonstrates the **bridge table pattern** to model many-to-many relationships.

## Pattern

```
students ←── enrollments ──→ courses
(1:M)        (bridge)        (M:1)
```

The `enrollments` table acts as a bridge/junction table with two many-to-one relationships:
- `enrollments.student_id → students.student_id`
- `enrollments.course_id → courses.course_id`

## Files

| File | Description |
|------|-------------|
| `semantic_views/many_to_many_sv.sql` | Table setup, sample data, and semantic view DDL |
| `.github/workflows/deploy.yml` | GitHub Actions CI/CD for auto-deployment |

## Deployment

### Manual (Snowsight Worksheet)

1. Open Snowsight → Worksheets → **+**
2. Paste contents of `semantic_views/many_to_many_sv.sql`
3. Update `USE DATABASE` / `USE SCHEMA` to match your environment
4. Run the worksheet

### Automated (GitHub Actions)

1. Add these secrets in **Settings → Secrets → Actions**:
   - `SNOWFLAKE_ACCOUNT`
   - `SNOWFLAKE_USER`
   - `SNOWFLAKE_PASSWORD`
2. Update the database/schema/warehouse in `.github/workflows/deploy.yml`
3. Push to `main` — deployment runs automatically

## Querying

```sql
SELECT * FROM SEMANTIC_VIEW(
  many_to_many_sv
  DIMENSIONS students.student_name, courses.course_name
  METRICS enrollments.enrollment_count
);
```

## Sample Output

| STUDENT_NAME | COURSE_NAME  | ENROLLMENT_COUNT |
|-------------|-------------|-----------------|
| Alice       | Mathematics | 1               |
| Alice       | Physics     | 1               |
| Bob         | Mathematics | 1               |
| Bob         | Chemistry   | 1               |
| Charlie     | Physics     | 1               |
| Charlie     | Chemistry   | 1               |
