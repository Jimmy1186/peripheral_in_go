--
-- Table structure for table `BackupLog`
--

DROP TABLE IF EXISTS `BackupLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `BackupLog` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `createAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `dbPath` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `BeforeLeftStation`
--

DROP TABLE IF EXISTS `BeforeLeftStation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `BeforeLeftStation` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `active` tinyint(1) NOT NULL DEFAULT '0',
    `amrId` json NOT NULL,
    `missionTitleId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `BeforeLeftStation_missionTitleId_fkey` (`missionTitleId`),
    CONSTRAINT `BeforeLeftStation_missionTitleId_fkey` FOREIGN KEY (`missionTitleId`) REFERENCES `MissionTitle` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `Category`
--

DROP TABLE IF EXISTS `Category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `Category` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `tagName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `color` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `Category_tagName_key` (`tagName`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `Direction`
--

DROP TABLE IF EXISTS `Direction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `Direction` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `yaw` double NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `Loc`
--

DROP TABLE IF EXISTS `Loc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `Loc` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `locationId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `x` double NOT NULL DEFAULT '0',
    `y` double NOT NULL DEFAULT '0',
    `canRotate` tinyint(1) NOT NULL DEFAULT '0',
    `connectedRoadIds` json DEFAULT NULL,
    `areaType` enum(
        'CHARGING',
        'DISPATCH',
        'STANDBY',
        'STORAGE',
        'EXTRA',
        'ELEVATOR',
        'ROBOTIC_ARM',
        'CONVEYOR',
        'LIFT_GATE',
        'GATE_WAIT_POINT',
        'PALLETIZER',
        'ROTATE_TABLE'
    ) COLLATE utf8mb4_unicode_ci NOT NULL,
    `cost` double NOT NULL DEFAULT '0',
    `translateX` double NOT NULL DEFAULT '-0.4',
    `translateY` double NOT NULL DEFAULT '-0.3',
    `rotate` int NOT NULL DEFAULT '0',
    `scale` double NOT NULL DEFAULT '1',
    `flex_direction` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'column-reverse',
    `placement_priority` int NOT NULL DEFAULT '0',
    `relationships` json DEFAULT NULL,
    `dirId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `shelfId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `prepare_point_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `mission_script_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `Loc_shelfId_key` (`shelfId`),
    KEY `Loc_dirId_fkey` (`dirId`),
    KEY `Loc_prepare_point_id_fkey` (`prepare_point_id`),
    KEY `Loc_mission_script_id_fkey` (`mission_script_id`),
    CONSTRAINT `Loc_dirId_fkey` FOREIGN KEY (`dirId`) REFERENCES `Direction` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `Loc_mission_script_id_fkey` FOREIGN KEY (`mission_script_id`) REFERENCES `mission_script` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `Loc_prepare_point_id_fkey` FOREIGN KEY (`prepare_point_id`) REFERENCES `Loc` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `Loc_shelfId_fkey` FOREIGN KEY (`shelfId`) REFERENCES `Shelf` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `MissionTitle`
--

DROP TABLE IF EXISTS `MissionTitle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `MissionTitle` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `robot_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `mission_folder_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `MissionTitle_name_key` (`name`),
    KEY `MissionTitle_robot_id_fkey` (`robot_id`),
    KEY `MissionTitle_mission_folder_id_fkey` (`mission_folder_id`),
    CONSTRAINT `MissionTitle_mission_folder_id_fkey` FOREIGN KEY (`mission_folder_id`) REFERENCES `mission_folder` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `MissionTitle_robot_id_fkey` FOREIGN KEY (`robot_id`) REFERENCES `robot_types` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `MissionTitleBridgeCategory`
--

DROP TABLE IF EXISTS `MissionTitleBridgeCategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `MissionTitleBridgeCategory` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `missionTitleId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `categoryId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `MissionTitleBridgeCategory_missionTitleId_fkey` (`missionTitleId`),
    KEY `MissionTitleBridgeCategory_categoryId_fkey` (`categoryId`),
    CONSTRAINT `MissionTitleBridgeCategory_categoryId_fkey` FOREIGN KEY (`categoryId`) REFERENCES `Category` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `MissionTitleBridgeCategory_missionTitleId_fkey` FOREIGN KEY (`missionTitleId`) REFERENCES `MissionTitle` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `Missions`
--

DROP TABLE IF EXISTS `Missions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `Missions` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `order` int DEFAULT NULL,
    `priority` int DEFAULT NULL,
    `send_by` int NOT NULL,
    `amrId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `status` int NOT NULL,
    `task` json DEFAULT NULL,
    `full_name` json DEFAULT NULL,
    `sub_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `category` json DEFAULT NULL,
    `manualMode` tinyint(1) NOT NULL DEFAULT '0',
    `emergencyBtn` tinyint(1) NOT NULL DEFAULT '0',
    `recoveryBtn` tinyint(1) NOT NULL DEFAULT '0',
    `createdAt` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
    `assignedAt` datetime(3) DEFAULT NULL,
    `startedAt` datetime(3) DEFAULT NULL,
    `completedAt` datetime(3) DEFAULT NULL,
    `warningIdList` json DEFAULT NULL,
    `batteryCost` int NOT NULL DEFAULT '0',
    `batteryRateWhenStarted` int NOT NULL DEFAULT '0',
    `totalDistanceTraveled` double NOT NULL DEFAULT '0',
    `simulate_scale` int NOT NULL DEFAULT '1',
    `info` json DEFAULT NULL,
    `message` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `cancel_reason` int DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `Missions_id_key` (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `Road`
--

DROP TABLE IF EXISTS `Road`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `Road` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `roadId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `priority` int NOT NULL DEFAULT '3',
    `startX` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `endTo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `roadType` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `disabled` tinyint(1) NOT NULL DEFAULT '0',
    `limit` tinyint(1) NOT NULL DEFAULT '0',
    `cost` double NOT NULL DEFAULT '0',
    `validYawList` json NOT NULL,
    `tolerance` double NOT NULL DEFAULT '0',
    `maxSpeed` double NOT NULL DEFAULT '0',
    `x1` double NOT NULL DEFAULT '0',
    `y1` double NOT NULL DEFAULT '0',
    `x2` double NOT NULL DEFAULT '0',
    `y2` double NOT NULL DEFAULT '0',
    `mission_script_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `Road_mission_script_id_fkey` (`mission_script_id`),
    CONSTRAINT `Road_mission_script_id_fkey` FOREIGN KEY (`mission_script_id`) REFERENCES `mission_script` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `ScheduleTask`
--

DROP TABLE IF EXISTS `ScheduleTask`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `ScheduleTask` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `active` tinyint(1) NOT NULL DEFAULT '0',
    `schedule` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `amrId` json NOT NULL,
    `missionTitleId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `ScheduleTask_missionTitleId_fkey` (`missionTitleId`),
    CONSTRAINT `ScheduleTask_missionTitleId_fkey` FOREIGN KEY (`missionTitleId`) REFERENCES `MissionTitle` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `Shelf`
--

DROP TABLE IF EXISTS `Shelf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `Shelf` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `shelfCategoryId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `Shelf_shelfCategoryId_fkey` (`shelfCategoryId`),
    CONSTRAINT `Shelf_shelfCategoryId_fkey` FOREIGN KEY (`shelfCategoryId`) REFERENCES `ShelfCategory` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `ShelfCategory`
--

DROP TABLE IF EXISTS `ShelfCategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `ShelfCategory` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `shelf_style` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'type_1',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `ShelfConfig`
--

DROP TABLE IF EXISTS `ShelfConfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `ShelfConfig` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `level` int NOT NULL DEFAULT '0',
    `hasCargo` tinyint(1) NOT NULL DEFAULT '0',
    `disable` tinyint(1) NOT NULL DEFAULT '0',
    `cargo_limit` int NOT NULL DEFAULT '0',
    `shelfId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `shelfHeightId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `ShelfConfig_name_key` (`name`),
    KEY `ShelfConfig_shelfHeightId_fkey` (`shelfHeightId`),
    KEY `ShelfConfig_shelfId_fkey` (`shelfId`),
    CONSTRAINT `ShelfConfig_name_fkey` FOREIGN KEY (`name`) REFERENCES `peripheral_name` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `ShelfConfig_shelfHeightId_fkey` FOREIGN KEY (`shelfHeightId`) REFERENCES `ShelfHeight` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `ShelfConfig_shelfId_fkey` FOREIGN KEY (`shelfId`) REFERENCES `Shelf` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `ShelfHeight`
--

DROP TABLE IF EXISTS `ShelfHeight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `ShelfHeight` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `height` int NOT NULL,
    `shelfCategoryId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `ShelfHeight_shelfCategoryId_fkey` (`shelfCategoryId`),
    CONSTRAINT `ShelfHeight_shelfCategoryId_fkey` FOREIGN KEY (`shelfCategoryId`) REFERENCES `ShelfCategory` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `TagSetting`
--

DROP TABLE IF EXISTS `TagSetting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `TagSetting` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `zone_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `speed_limit` double DEFAULT NULL,
    `hight_limit` double DEFAULT NULL,
    `limitNum` int DEFAULT NULL,
    `forbidden_car` json DEFAULT NULL,
    `view_available` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `TagSetting_zone_id_key` (`zone_id`),
    CONSTRAINT `TagSetting_zone_id_fkey` FOREIGN KEY (`zone_id`) REFERENCES `Zone` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `TitleBridgeLoc`
--

DROP TABLE IF EXISTS `TitleBridgeLoc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `TitleBridgeLoc` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `missionType` enum('load', 'offload') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `missionOrder` int NOT NULL DEFAULT '0',
    `titleId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `locId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `TitleBridgeLoc_locId_fkey` (`locId`),
    KEY `TitleBridgeLoc_titleId_fkey` (`titleId`),
    CONSTRAINT `TitleBridgeLoc_locId_fkey` FOREIGN KEY (`locId`) REFERENCES `Loc` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `TitleBridgeLoc_titleId_fkey` FOREIGN KEY (`titleId`) REFERENCES `MissionTitle` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `UserInFo`
--

DROP TABLE IF EXISTS `UserInFo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `UserInFo` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `account` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    `status` enum(
        'GENERALLY',
        'ENGINEER',
        'ADMIN'
    ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'GENERALLY',
    PRIMARY KEY (`id`),
    UNIQUE KEY `UserInFo_account_key` (`account`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `Zone`
--

DROP TABLE IF EXISTS `Zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `Zone` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `start_point_x` double NOT NULL,
    `start_point_y` double NOT NULL,
    `end_point_x` double NOT NULL,
    `end_point_y` double NOT NULL,
    `background_color` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `category` json NOT NULL,
    `mission_script_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `layer` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
    `lidar_back` tinyint(1) NOT NULL,
    `lidar_front` tinyint(1) NOT NULL,
    PRIMARY KEY (`id`),
    KEY `Zone_mission_script_id_fkey` (`mission_script_id`),
    CONSTRAINT `Zone_mission_script_id_fkey` FOREIGN KEY (`mission_script_id`) REFERENCES `mission_script` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `abort_mission_when_has_cargo_task`
--

DROP TABLE IF EXISTS `abort_mission_when_has_cargo_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `abort_mission_when_has_cargo_task` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `active` tinyint(1) NOT NULL DEFAULT '0',
    `amr_id` json NOT NULL,
    `mission_title_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`),
    KEY `abort_mission_when_has_cargo_task_mission_title_id_fkey` (`mission_title_id`),
    CONSTRAINT `abort_mission_when_has_cargo_task_mission_title_id_fkey` FOREIGN KEY (`mission_title_id`) REFERENCES `MissionTitle` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `alarm_id_history`
--

DROP TABLE IF EXISTS `alarm_id_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `alarm_id_history` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `amr_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `resolvedAt` datetime(3) DEFAULT NULL,
    `is_active` tinyint(1) NOT NULL DEFAULT '1',
    `alarm_id` int NOT NULL,
    PRIMARY KEY (`id`),
    KEY `alarm_id_history_alarm_id_fkey` (`alarm_id`),
    CONSTRAINT `alarm_id_history_alarm_id_fkey` FOREIGN KEY (`alarm_id`) REFERENCES `alarm_id_list` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `alarm_id_list`
--

DROP TABLE IF EXISTS `alarm_id_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `alarm_id_list` (
    `id` int NOT NULL,
    `is_open_buzzer` tinyint(1) NOT NULL,
    `info_ch` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `info_en` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `solution_ch` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `solution_en` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `alarm_id_list_id_key` (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `cargo_history`
--

DROP TABLE IF EXISTS `cargo_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `cargo_history` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `cargo_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `action` enum(
        'CREATED',
        'TRANSFER',
        'LOAD',
        'OFFLOAD',
        'SHIFTED',
        'UPDATED'
    ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `description` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `actor` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `timestamp` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    PRIMARY KEY (`id`),
    KEY `cargo_history_cargo_id_fkey` (`cargo_id`),
    CONSTRAINT `cargo_history_cargo_id_fkey` FOREIGN KEY (`cargo_id`) REFERENCES `cargo_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `cargo_info`
--

DROP TABLE IF EXISTS `cargo_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `cargo_info` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `is_real` tinyint(1) NOT NULL DEFAULT '1',
    `status` enum(
        'PRE_SPAWN',
        'ON_AMR',
        'AT_LOCATION',
        'SHIFT'
    ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `metadata` json DEFAULT NULL,
    `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` datetime(3) NOT NULL,
    `register_robot_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `script_robot_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `shelfConfigId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `custom_cargo_metadata_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `conveyor_configId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `elevator_config_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `custom_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `owner` enum(
        'CONVEYOR',
        'ELEVATOR',
        'SHIFT',
        'AMR',
        'STORAGE'
    ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`),
    KEY `cargo_info_register_robot_id_fkey` (`register_robot_id`),
    KEY `cargo_info_script_robot_id_fkey` (`script_robot_id`),
    KEY `cargo_info_shelfConfigId_fkey` (`shelfConfigId`),
    KEY `cargo_info_custom_cargo_metadata_id_fkey` (`custom_cargo_metadata_id`),
    KEY `cargo_info_conveyor_configId_fkey` (`conveyor_configId`),
    KEY `cargo_info_elevator_config_id_fkey` (`elevator_config_id`),
    CONSTRAINT `cargo_info_conveyor_configId_fkey` FOREIGN KEY (`conveyor_configId`) REFERENCES `conveyor_config` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `cargo_info_custom_cargo_metadata_id_fkey` FOREIGN KEY (`custom_cargo_metadata_id`) REFERENCES `custom_cargo_metadata` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `cargo_info_elevator_config_id_fkey` FOREIGN KEY (`elevator_config_id`) REFERENCES `elevator_config` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `cargo_info_register_robot_id_fkey` FOREIGN KEY (`register_robot_id`) REFERENCES `register_robot` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `cargo_info_script_robot_id_fkey` FOREIGN KEY (`script_robot_id`) REFERENCES `script_robot` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `cargo_info_shelfConfigId_fkey` FOREIGN KEY (`shelfConfigId`) REFERENCES `ShelfConfig` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `charge_mission`
--

DROP TABLE IF EXISTS `charge_mission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `charge_mission` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `active` tinyint(1) NOT NULL DEFAULT '0',
    `aggressiveThreshold` int DEFAULT NULL,
    `fullThreshold` int DEFAULT NULL,
    `availableGetTaskThreshold` int DEFAULT NULL,
    `missionTitleId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `passiveThreshold` int DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `ChargeMission_missionTitleId_fkey` (`missionTitleId`),
    CONSTRAINT `charge_mission_missionTitleId_fkey` FOREIGN KEY (`missionTitleId`) REFERENCES `MissionTitle` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `charge_station_config`
--

DROP TABLE IF EXISTS `charge_station_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `charge_station_config` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `station_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '01',
    `disable` tinyint(1) NOT NULL DEFAULT '0',
    `charge_speed_ms` int NOT NULL DEFAULT '2000',
    `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `mock_wcs_stationId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `charge_station_config_name_key` (`name`),
    CONSTRAINT `charge_station_config_name_fkey` FOREIGN KEY (`name`) REFERENCES `peripheral_name` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `conveyor_config`
--

DROP TABLE IF EXISTS `conveyor_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `conveyor_config` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `hasCargo` tinyint(1) NOT NULL DEFAULT '0',
    `disable` tinyint(1) NOT NULL DEFAULT '0',
    `fork_height` int NOT NULL DEFAULT '300',
    `active_load` tinyint(1) NOT NULL DEFAULT '0',
    `active_offload` tinyint(1) NOT NULL DEFAULT '0',
    `loading_time_ms` int NOT NULL DEFAULT '2000',
    `unloading_time_ms` int NOT NULL DEFAULT '2000',
    `is_spawn_cargo` tinyint(1) NOT NULL DEFAULT '0',
    `spawn_time_ms` int NOT NULL DEFAULT '10000',
    `active_shift` tinyint(1) NOT NULL DEFAULT '0',
    `shift_time_ms` int NOT NULL DEFAULT '2000',
    `shift_location_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `conveyor_config_name_key` (`name`),
    KEY `conveyor_config_shift_location_id_fkey` (`shift_location_id`),
    CONSTRAINT `conveyor_config_name_fkey` FOREIGN KEY (`name`) REFERENCES `peripheral_name` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `conveyor_config_shift_location_id_fkey` FOREIGN KEY (`shift_location_id`) REFERENCES `Loc` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `custom_cargo_metadata`
--

DROP TABLE IF EXISTS `custom_cargo_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `custom_cargo_metadata` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `is_default` tinyint(1) NOT NULL DEFAULT '0',
    `custom_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `format` json NOT NULL,
    `unique_key` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `cycle_task`
--

DROP TABLE IF EXISTS `cycle_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `cycle_task` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `amr_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `mission_title_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`),
    KEY `cycle_task_mission_title_id_fkey` (`mission_title_id`),
    CONSTRAINT `cycle_task_mission_title_id_fkey` FOREIGN KEY (`mission_title_id`) REFERENCES `MissionTitle` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `dynamic_mission_bridge`
--

DROP TABLE IF EXISTS `dynamic_mission_bridge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `dynamic_mission_bridge` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `order` int NOT NULL,
    `load_name_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `offload_name_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `timeline_mission_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `dynamic_mission_bridge_load_name_id_fkey` (`load_name_id`),
    KEY `dynamic_mission_bridge_offload_name_id_fkey` (`offload_name_id`),
    KEY `fk_dynamic_mission_bridge_timeline` (`timeline_mission_id`),
    CONSTRAINT `dynamic_mission_bridge_load_name_id_fkey` FOREIGN KEY (`load_name_id`) REFERENCES `peripheral_name` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `dynamic_mission_bridge_offload_name_id_fkey` FOREIGN KEY (`offload_name_id`) REFERENCES `peripheral_name` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_dynamic_mission_bridge_timeline` FOREIGN KEY (`timeline_mission_id`) REFERENCES `timeline_mission` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `dynamic_mission_peripheral_group_for_timeline`
--

DROP TABLE IF EXISTS `dynamic_mission_peripheral_group_for_timeline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `dynamic_mission_peripheral_group_for_timeline` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `range` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `active_interval` int NOT NULL DEFAULT '-1',
    `timeline_mission_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `dynamic_mission_peripheral_group_for_timeline_timeline_missi_key` (`timeline_mission_id`),
    CONSTRAINT `dynamic_mission_peripheral_group_for_timeline_timeline_miss_fkey` FOREIGN KEY (`timeline_mission_id`) REFERENCES `timeline_mission` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `elevator_config`
--

DROP TABLE IF EXISTS `elevator_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `elevator_config` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `hasCargo` tinyint(1) NOT NULL DEFAULT '0',
    `disable` tinyint(1) NOT NULL DEFAULT '0',
    `fork_height` int NOT NULL DEFAULT '300',
    `loading_time_ms` int NOT NULL DEFAULT '2000',
    `unloading_time_ms` int NOT NULL DEFAULT '2000',
    `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `elevator_config_name_key` (`name`),
    CONSTRAINT `elevator_config_name_fkey` FOREIGN KEY (`name`) REFERENCES `peripheral_name` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `feedback_task`
--

DROP TABLE IF EXISTS `feedback_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `feedback_task` (
    `id` int NOT NULL AUTO_INCREMENT,
    `amr_id` json NOT NULL,
    `obtain_id` json NOT NULL,
    `active` tinyint(1) NOT NULL DEFAULT '0',
    `mission_title_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`),
    KEY `feedback_task_mission_title_id_fkey` (`mission_title_id`),
    CONSTRAINT `feedback_task_mission_title_id_fkey` FOREIGN KEY (`mission_title_id`) REFERENCES `MissionTitle` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `feedback_task_anytime`
--

DROP TABLE IF EXISTS `feedback_task_anytime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `feedback_task_anytime` (
    `id` int NOT NULL AUTO_INCREMENT,
    `amr_id` json NOT NULL,
    `obtain_id` json NOT NULL,
    `active` tinyint(1) NOT NULL DEFAULT '0',
    `mission_title_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`),
    KEY `feedback_task_anytime_mission_title_id_fkey` (`mission_title_id`),
    CONSTRAINT `feedback_task_anytime_mission_title_id_fkey` FOREIGN KEY (`mission_title_id`) REFERENCES `MissionTitle` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `gate_wait_point_config`
--

DROP TABLE IF EXISTS `gate_wait_point_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `gate_wait_point_config` (
    `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
    `disable` tinyint(1) NOT NULL DEFAULT '0',
    `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `gate_wait_point_config_name_key` (`name`),
    CONSTRAINT `gate_wait_point_config_name_fkey` FOREIGN KEY (`name`) REFERENCES `peripheral_name` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `idle_task`
--

DROP TABLE IF EXISTS `idle_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `idle_task` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `active` tinyint(1) NOT NULL DEFAULT '0',
    `idle_min` double NOT NULL,
    `prevent_location` json DEFAULT NULL,
    `mission_title_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`),
    KEY `idle_task_mission_title_id_fkey` (`mission_title_id`),
    CONSTRAINT `idle_task_mission_title_id_fkey` FOREIGN KEY (`mission_title_id`) REFERENCES `MissionTitle` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `lift_gate_config`
--

DROP TABLE IF EXISTS `lift_gate_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `lift_gate_config` (
    `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
    `disable` tinyint(1) NOT NULL DEFAULT '0',
    `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `lift_gate_config_name_key` (`name`),
    CONSTRAINT `lift_gate_config_name_fkey` FOREIGN KEY (`name`) REFERENCES `peripheral_name` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `load_offload_for_timeline_group`
--

DROP TABLE IF EXISTS `load_offload_for_timeline_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `load_offload_for_timeline_group` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `order` int NOT NULL,
    `load_group_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `offload_group_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `dmpg_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`),
    KEY `load_offload_for_timeline_group_load_group_id_fkey` (`load_group_id`),
    KEY `load_offload_for_timeline_group_offload_group_id_fkey` (`offload_group_id`),
    KEY `load_offload_for_timeline_group_dmpg_id_fkey` (`dmpg_id`),
    CONSTRAINT `load_offload_for_timeline_group_dmpg_id_fkey` FOREIGN KEY (`dmpg_id`) REFERENCES `dynamic_mission_peripheral_group_for_timeline` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `load_offload_for_timeline_group_load_group_id_fkey` FOREIGN KEY (`load_group_id`) REFERENCES `peripheral_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `load_offload_for_timeline_group_offload_group_id_fkey` FOREIGN KEY (`offload_group_id`) REFERENCES `peripheral_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `maps`
--

DROP TABLE IF EXISTS `maps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `maps` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `fileName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `isUsing` tinyint(1) NOT NULL DEFAULT '0',
    `mapOriginX` double NOT NULL DEFAULT '0',
    `mapOriginY` double NOT NULL DEFAULT '0',
    `mapWidth` int NOT NULL DEFAULT '0',
    `mapHeight` int NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`),
    UNIQUE KEY `maps_fileName_key` (`fileName`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `mission_folder`
--

DROP TABLE IF EXISTS `mission_folder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `mission_folder` (
    `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
    `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `mission_folder_name_key` (`name`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `mission_script`
--

DROP TABLE IF EXISTS `mission_script`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `mission_script` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `isUsing` tinyint(1) NOT NULL DEFAULT '0',
    `start_point` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `mission_script_name_key` (`name`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `mission_slice`
--

DROP TABLE IF EXISTS `mission_slice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `mission_slice` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `process_order` int NOT NULL,
    `disable` tinyint(1) NOT NULL DEFAULT '0',
    `detail` json NOT NULL,
    `missionTitleId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`),
    KEY `mission_slice_missionTitleId_fkey` (`missionTitleId`),
    CONSTRAINT `mission_slice_missionTitleId_fkey` FOREIGN KEY (`missionTitleId`) REFERENCES `MissionTitle` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `mock_wcs_station`
--

DROP TABLE IF EXISTS `mock_wcs_station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `mock_wcs_station` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `machine_type` enum(
        'CONVEYOR',
        'LIFT_GATE',
        'GATE_WAIT_POINT',
        'ROBOTIC_ARM',
        'ELEVATOR',
        'PALLETIZER',
        'CHARGING'
    ) COLLATE utf8mb4_unicode_ci NOT NULL,
    `delay_ms` int NOT NULL,
    `is_enabled` tinyint(1) NOT NULL DEFAULT '1',
    `sourceId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `mission_script_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `conveyor_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `elevator_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `charge_station_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `lift_gate_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `gate_wait_point_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `mock_wcs_station_sourceId_key` (`sourceId`),
    UNIQUE KEY `mock_wcs_station_conveyor_id_key` (`conveyor_id`),
    UNIQUE KEY `mock_wcs_station_elevator_id_key` (`elevator_id`),
    UNIQUE KEY `mock_wcs_station_charge_station_id_key` (`charge_station_id`),
    UNIQUE KEY `mock_wcs_station_lift_gate_id_key` (`lift_gate_id`),
    UNIQUE KEY `mock_wcs_station_gate_wait_point_id_key` (`gate_wait_point_id`),
    KEY `mock_wcs_station_mission_script_id_fkey` (`mission_script_id`),
    CONSTRAINT `mock_wcs_station_charge_station_id_fkey` FOREIGN KEY (`charge_station_id`) REFERENCES `charge_station_config` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `mock_wcs_station_conveyor_id_fkey` FOREIGN KEY (`conveyor_id`) REFERENCES `conveyor_config` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `mock_wcs_station_elevator_id_fkey` FOREIGN KEY (`elevator_id`) REFERENCES `elevator_config` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `mock_wcs_station_gate_wait_point_id_fkey` FOREIGN KEY (`gate_wait_point_id`) REFERENCES `gate_wait_point_config` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `mock_wcs_station_lift_gate_id_fkey` FOREIGN KEY (`lift_gate_id`) REFERENCES `lift_gate_config` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `mock_wcs_station_mission_script_id_fkey` FOREIGN KEY (`mission_script_id`) REFERENCES `mission_script` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `mock_wcs_station_sourceId_fkey` FOREIGN KEY (`sourceId`) REFERENCES `Loc` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `peripheral_group`
--

DROP TABLE IF EXISTS `peripheral_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `peripheral_group` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `description` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `mission_script_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `peripheral_group_name_key` (`name`),
    KEY `peripheral_group_mission_script_id_fkey` (`mission_script_id`),
    CONSTRAINT `peripheral_group_mission_script_id_fkey` FOREIGN KEY (`mission_script_id`) REFERENCES `mission_script` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `peripheral_name`
--

DROP TABLE IF EXISTS `peripheral_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `peripheral_name` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `description` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    `quantity` int NOT NULL DEFAULT '0',
    `type` enum(
        'CHARGING',
        'DISPATCH',
        'STANDBY',
        'STORAGE',
        'EXTRA',
        'ELEVATOR',
        'ROBOTIC_ARM',
        'CONVEYOR',
        'LIFT_GATE',
        'GATE_WAIT_POINT',
        'PALLETIZER',
        'ROTATE_TABLE'
    ) COLLATE utf8mb4_unicode_ci NOT NULL,
    `group_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `load_priority` int NOT NULL DEFAULT '0',
    `offload_priority` int NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`),
    UNIQUE KEY `peripheral_name_name_key` (`name`),
    KEY `peripheral_name_group_id_fkey` (`group_id`),
    CONSTRAINT `peripheral_name_group_id_fkey` FOREIGN KEY (`group_id`) REFERENCES `peripheral_group` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `register_robot`
--

DROP TABLE IF EXISTS `register_robot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `register_robot` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `full_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `serialNum` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `is_enable` tinyint(1) NOT NULL DEFAULT '1',
    `maintenance_level` int NOT NULL DEFAULT '7',
    `robot_type_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `charge_mission_setting_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `idle_mission_setting_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `register_robot_full_name_key` (`full_name`),
    UNIQUE KEY `register_robot_serialNum_key` (`serialNum`),
    KEY `register_robot_robot_type_id_fkey` (`robot_type_id`),
    KEY `register_robot_charge_mission_setting_id_fkey` (`charge_mission_setting_id`),
    KEY `register_robot_idle_mission_setting_id_fkey` (`idle_mission_setting_id`),
    CONSTRAINT `register_robot_charge_mission_setting_id_fkey` FOREIGN KEY (`charge_mission_setting_id`) REFERENCES `charge_mission` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `register_robot_idle_mission_setting_id_fkey` FOREIGN KEY (`idle_mission_setting_id`) REFERENCES `idle_task` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `register_robot_robot_type_id_fkey` FOREIGN KEY (`robot_type_id`) REFERENCES `robot_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `robot_types`
--

DROP TABLE IF EXISTS `robot_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `robot_types` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `value` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `length` double NOT NULL DEFAULT '0',
    `width` double NOT NULL DEFAULT '0',
    `height` double NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`),
    UNIQUE KEY `robot_types_name_key` (`name`),
    UNIQUE KEY `robot_types_value_key` (`value`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `script_robot`
--

DROP TABLE IF EXISTS `script_robot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `script_robot` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `full_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `is_in_script` tinyint(1) NOT NULL DEFAULT '0',
    `load_speed` int NOT NULL DEFAULT '30',
    `offload_speed` int NOT NULL DEFAULT '30',
    `move_speed` double NOT NULL DEFAULT '1.5',
    `script_placement_location` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unset',
    `serialNum` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `maintenance_level` int NOT NULL DEFAULT '0',
    `mission_script_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `charge_mission_setting_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `idle_mission_setting_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `robot_type_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `script_robot_serialNum_key` (`serialNum`),
    KEY `script_robot_mission_script_id_fkey` (`mission_script_id`),
    KEY `script_robot_charge_mission_setting_id_fkey` (`charge_mission_setting_id`),
    KEY `script_robot_idle_mission_setting_id_fkey` (`idle_mission_setting_id`),
    KEY `script_robot_robot_type_id_fkey` (`robot_type_id`),
    CONSTRAINT `script_robot_charge_mission_setting_id_fkey` FOREIGN KEY (`charge_mission_setting_id`) REFERENCES `charge_mission` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `script_robot_idle_mission_setting_id_fkey` FOREIGN KEY (`idle_mission_setting_id`) REFERENCES `idle_task` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `script_robot_mission_script_id_fkey` FOREIGN KEY (`mission_script_id`) REFERENCES `mission_script` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `script_robot_robot_type_id_fkey` FOREIGN KEY (`robot_type_id`) REFERENCES `robot_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `shift_cargo_peripheral_group_bridge`
--

DROP TABLE IF EXISTS `shift_cargo_peripheral_group_bridge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `shift_cargo_peripheral_group_bridge` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `range` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `active_interval` int NOT NULL DEFAULT '-1',
    `is_shift_all` tinyint(1) NOT NULL DEFAULT '0',
    `shift_number` int NOT NULL,
    `timeline_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `peripheral_group_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `shift_cargo_peripheral_group_bridge_timeline_id_key` (`timeline_id`),
    KEY `shift_cargo_peripheral_group_bridge_peripheral_group_id_fkey` (`peripheral_group_id`),
    CONSTRAINT `shift_cargo_peripheral_group_bridge_peripheral_group_id_fkey` FOREIGN KEY (`peripheral_group_id`) REFERENCES `peripheral_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `shift_cargo_peripheral_group_bridge_timeline_id_fkey` FOREIGN KEY (`timeline_id`) REFERENCES `timeline` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `simulation_result`
--

DROP TABLE IF EXISTS `simulation_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `simulation_result` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `amr_stat` json NOT NULL,
    `startTime` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `endTime` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `total_cargos_carried` int NOT NULL,
    `mission_success_rate` int NOT NULL,
    `total_mission_count` int NOT NULL,
    `completed_missions` int NOT NULL,
    `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `spawn_cargo_peripheral_group_bridge`
--

DROP TABLE IF EXISTS `spawn_cargo_peripheral_group_bridge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `spawn_cargo_peripheral_group_bridge` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `range` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `active_interval` int NOT NULL DEFAULT '-1',
    `is_spawn_all` tinyint(1) NOT NULL DEFAULT '0',
    `spawn_number` int NOT NULL,
    `timeline_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `peripheral_group_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `spawn_cargo_info_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `spawn_cargo_peripheral_group_bridge_timeline_id_key` (`timeline_id`),
    KEY `spawn_cargo_peripheral_group_bridge_peripheral_group_id_fkey` (`peripheral_group_id`),
    KEY `spawn_cargo_peripheral_group_bridge_spawn_cargo_info_id_fkey` (`spawn_cargo_info_id`),
    CONSTRAINT `spawn_cargo_peripheral_group_bridge_peripheral_group_id_fkey` FOREIGN KEY (`peripheral_group_id`) REFERENCES `peripheral_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `spawn_cargo_peripheral_group_bridge_spawn_cargo_info_id_fkey` FOREIGN KEY (`spawn_cargo_info_id`) REFERENCES `cargo_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `spawn_cargo_peripheral_group_bridge_timeline_id_fkey` FOREIGN KEY (`timeline_id`) REFERENCES `timeline` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `test` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `msg` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `timeline`
--

DROP TABLE IF EXISTS `timeline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `timeline` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `timestamp` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `event_type` enum('GROUP', 'FIXED') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'FIXED',
    `type` enum(
        'SPAWN_CARGO',
        'SHIFT_CARGO',
        'MISSION',
        'SPAWN_CARGO_GROUP',
        'SHIFT_CARGO_GROUP'
    ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `is_enable` tinyint(1) NOT NULL DEFAULT '1',
    `style_row` int NOT NULL DEFAULT '0',
    `shift_peripheral_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `simulation_result_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `script_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`),
    KEY `timeline_shift_peripheral_id_fkey` (`shift_peripheral_id`),
    KEY `timeline_simulation_result_id_fkey` (`simulation_result_id`),
    KEY `timeline_script_id_fkey` (`script_id`),
    CONSTRAINT `timeline_script_id_fkey` FOREIGN KEY (`script_id`) REFERENCES `mission_script` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `timeline_shift_peripheral_id_fkey` FOREIGN KEY (`shift_peripheral_id`) REFERENCES `peripheral_name` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `timeline_simulation_result_id_fkey` FOREIGN KEY (`simulation_result_id`) REFERENCES `simulation_result` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `timeline_mission`
--

DROP TABLE IF EXISTS `timeline_mission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `timeline_mission` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `priority` int NOT NULL,
    `type` enum(
        'DYNAMIC',
        'NOTIFY',
        'NORMAL',
        'GROUP_TO_GROUP'
    ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `amr_relate_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `mission_title_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `notify_name_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `timeline_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `timeline_mission_timeline_id_key` (`timeline_id`),
    KEY `timeline_mission_amr_relate_id_fkey` (`amr_relate_id`),
    KEY `timeline_mission_mission_title_id_fkey` (`mission_title_id`),
    KEY `timeline_mission_notify_name_id_fkey` (`notify_name_id`),
    CONSTRAINT `timeline_mission_amr_relate_id_fkey` FOREIGN KEY (`amr_relate_id`) REFERENCES `script_robot` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `timeline_mission_mission_title_id_fkey` FOREIGN KEY (`mission_title_id`) REFERENCES `MissionTitle` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `timeline_mission_notify_name_id_fkey` FOREIGN KEY (`notify_name_id`) REFERENCES `peripheral_name` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `timeline_mission_timeline_id_fkey` FOREIGN KEY (`timeline_id`) REFERENCES `timeline` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `timeline_spawn_cargo`
--

DROP TABLE IF EXISTS `timeline_spawn_cargo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `timeline_spawn_cargo` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `peripheral_name_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `spawn_cargo_info_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `timeline_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `timeline_spawn_cargo_timeline_id_key` (`timeline_id`),
    KEY `timeline_spawn_cargo_peripheral_name_id_fkey` (`peripheral_name_id`),
    KEY `timeline_spawn_cargo_spawn_cargo_info_id_fkey` (`spawn_cargo_info_id`),
    CONSTRAINT `timeline_spawn_cargo_peripheral_name_id_fkey` FOREIGN KEY (`peripheral_name_id`) REFERENCES `peripheral_name` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `timeline_spawn_cargo_spawn_cargo_info_id_fkey` FOREIGN KEY (`spawn_cargo_info_id`) REFERENCES `cargo_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `timeline_spawn_cargo_timeline_id_fkey` FOREIGN KEY (`timeline_id`) REFERENCES `timeline` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `topic_task`
--

DROP TABLE IF EXISTS `topic_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `topic_task` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `active` tinyint(1) NOT NULL DEFAULT '0',
    `amr_id` json NOT NULL,
    `topic_id` int NOT NULL,
    `mission_title_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`),
    KEY `topic_task_mission_title_id_fkey` (`mission_title_id`),
    CONSTRAINT `topic_task_mission_title_id_fkey` FOREIGN KEY (`mission_title_id`) REFERENCES `MissionTitle` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `warning_id_history`
--

DROP TABLE IF EXISTS `warning_id_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `warning_id_history` (
    `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `amr_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `resolvedAt` datetime(3) DEFAULT NULL,
    `is_active` tinyint(1) NOT NULL DEFAULT '1',
    `warning_id` int NOT NULL,
    PRIMARY KEY (`id`),
    KEY `warning_id_history_warning_id_fkey` (`warning_id`),
    CONSTRAINT `warning_id_history_warning_id_fkey` FOREIGN KEY (`warning_id`) REFERENCES `warning_id_list` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;

--
-- Table structure for table `warning_id_list`
--

DROP TABLE IF EXISTS `warning_id_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `warning_id_list` (
    `id` int NOT NULL,
    `is_open_buzzer` tinyint(1) NOT NULL,
    `info_ch` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `info_en` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `solution_ch` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `solution_en` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `warning_id_list_id_key` (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;