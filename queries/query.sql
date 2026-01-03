



-- name: AllTitleBridgeLoc :many
SELECT 
    mtbc.id,
    mt.name AS title_name,
    c.tagName AS category_name,
    c.color AS category_color
FROM MissionTitleBridgeCategory mtbc
LEFT JOIN MissionTitle mt ON mtbc.missionTitleId = mt.id
LEFT JOIN Category c ON mtbc.categoryId = c.id;


-- name: AllStack :many
SELECT 
    ms.id,
    loc.locationId AS locationId,
    stack.id AS stackId,
    stack.disable AS stack_disable,
    stack.heights AS stack_heights,
    stack.stack_count AS stack_count,
    -- cargo_info.id as cargo_id,
    -- cargo_info.status as cargo_status,
    -- cargo_info.metadata as cargo_metadata,
    -- cargo_info.custom_id as cargo_custom_id,
    -- cargo_info.custom_cargo_metadata_id as custom_cargo_metadata_id,
    peripheral_name.name as peripheral_name,
    peripheral_name.description as peripheral_desc
FROM mission_script ms
 JOIN Loc loc ON ms.id = loc.mission_script_id
 JOIN mock_wcs_station mws ON loc.id = mws.sourceId
 JOIN stack_config stack ON mws.stack_id = stack.id
--  JOIN cargo_info ON stack.id = cargo_info.stack_config_id
 JOIN peripheral_name ON stack.name = peripheral_name.id
 WHERE ms.id = ?;

-- name: ListCargosByStackIds :many
SELECT 
    stack_config_id,
    id as cargo_id,
    status as cargo_status,
    metadata as cargo_metadata,
    custom_id as cargo_custom_id
FROM cargo_info 
-- sqlc 支援傳入 slice: WHERE stack_config_id IN (?)
WHERE stack_config_id IN (sqlc.slice('stackIds'));


-- name: OneStack :one
SELECT 
    ms.id,
    loc.locationId AS locationId,
    stack.id AS stackId,
    stack.disable AS stack_disable,
    stack.heights AS stack_heights,
    stack.stack_count AS stack_count,
    -- cargo_info.id as cargo_id,
    -- cargo_info.status as cargo_status,
    -- cargo_info.metadata as cargo_metadata,
    -- cargo_info.custom_id as cargo_custom_id,
    -- cargo_info.custom_cargo_metadata_id as custom_cargo_metadata_id,
    peripheral_name.name as peripheral_name,
    peripheral_name.description as peripheral_desc
FROM mission_script ms
 JOIN Loc loc ON ms.id = loc.mission_script_id
 JOIN mock_wcs_station mws ON loc.id = mws.sourceId
 JOIN stack_config stack ON mws.stack_id = stack.id
--  JOIN cargo_info ON stack.id = cargo_info.stack_config_id
 JOIN peripheral_name ON stack.name = peripheral_name.id
 WHERE ms.id = ? AND loc.locationId = ?;