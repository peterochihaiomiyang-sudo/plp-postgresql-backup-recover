-- Display the category hierarchy using a recursive CTE.
WITH RECURSIVE tree AS (
  SELECT id, name, parent_id, 0 AS depth,
         ARRAY[id] AS path
  FROM public.categories
  WHERE parent_id IS NULL

  UNION ALL

  SELECT c.id, c.name, c.parent_id, t.depth + 1,
         t.path || c.id
  FROM public.categories c
  JOIN tree t ON c.parent_id = t.id
  WHERE NOT c.id = ANY(t.path)
)
SELECT repeat('  ', depth) || name AS tree,
       id, parent_id, depth
FROM tree
ORDER BY path;
