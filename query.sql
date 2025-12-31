



-- name: AllTitleBridgeLoc :many
SELECT 
    mtbc.id,
    mt.name AS title_name,
    c.tagName AS category_name,
    c.color AS category_color
FROM MissionTitleBridgeCategory mtbc
LEFT JOIN MissionTitle mt ON mtbc.missionTitleId = mt.id
LEFT JOIN Category c ON mtbc.categoryId = c.id;