# Many-to-Many Relationship — Bridge Table Pattern (Snowflake Semantic Views)

```
students ←── enrollments ──→ courses
(1:M)        (bridge)        (M:1)
```

Snowflake semantic views don't support many-to-many directly. Use a bridge table with two many-to-one relationships.

## Deploy

1. Open **Snowsight → Worksheets → +**
2. Paste `semantic_views/many_to_many_sv.sql`
3. Update `USE DATABASE` / `USE SCHEMA`
4. Run

## Query

```sql
SELECT * FROM SEMANTIC_VIEW(
  many_to_many_sv
  DIMENSIONS students.student_name, courses.course_name
  METRICS enrollments.enrollment_count
);
```
