USE master
IF EXISTS(select * from sys.databases where name='decision_tree')
DROP DATABASE decision_tree

CREATE DATABASE decision_tree
GO

USE decision_tree
CREATE TABLE ComponentType
(
Id INT PRIMARY KEY IDENTITY(1,1),
Name VARCHAR (50) NOT NULL
)
GO
CREATE TABLE ComponentValue
(
Id INT PRIMARY KEY IDENTITY(1,1),
InnerValue VARCHAR (50) NOT NULL,
DisplayValue VARCHAR (100)
)
GO
CREATE TABLE DecisionTree
(
Id INT PRIMARY KEY IDENTITY(1,1),
ParentId INT NOT NULL,
ComponentTypeId INT NOT NULL,
ComponentValueId INT NULL
)
GO
ALTER TABLE [dbo].[DecisionTree]  WITH CHECK ADD  CONSTRAINT [FK_DecisionTree_ComponentType] FOREIGN KEY(ComponentTypeId)
REFERENCES [dbo].[ComponentType] ([Id])
ON DELETE CASCADE
GO
 
ALTER TABLE [dbo].[DecisionTree] CHECK CONSTRAINT [FK_DecisionTree_ComponentType]
GO

ALTER TABLE [dbo].[DecisionTree]  WITH CHECK ADD  CONSTRAINT [FK_DecisionTree_ComponentValue] FOREIGN KEY(ComponentValueId)
REFERENCES [dbo].[ComponentValue] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[DecisionTree] CHECK CONSTRAINT [FK_DecisionTree_ComponentValue]
GO

SET IDENTITY_INSERT ComponentType ON
INSERT INTO ComponentType(Id, Name) VALUES (1,'select')
INSERT INTO ComponentType(Id, Name) VALUES (2,'select-option')
INSERT INTO ComponentType(Id, Name) VALUES (3,'text')
SET IDENTITY_INSERT ComponentType OFF

SET IDENTITY_INSERT ComponentValue ON
INSERT INTO ComponentValue(Id, InnerValue, DisplayValue) VALUES (1,'zoo', 'Zoo')
INSERT INTO ComponentValue(Id, InnerValue, DisplayValue) VALUES (2,'predators', 'Predators')
INSERT INTO ComponentValue(Id, InnerValue, DisplayValue) VALUES (3,'herbivores', 'Herbivores')
INSERT INTO ComponentValue(Id, InnerValue, DisplayValue) VALUES (4,'tiger', 'Tiger')
INSERT INTO ComponentValue(Id, InnerValue, DisplayValue) VALUES (5,'leon', 'Leon')
INSERT INTO ComponentValue(Id, InnerValue, DisplayValue) VALUES (6,'zebra', 'Zebra')
INSERT INTO ComponentValue(Id, InnerValue, DisplayValue) VALUES (7,'buffalo', 'Buffalo')
INSERT INTO ComponentValue(Id, InnerValue, DisplayValue) VALUES (8,'antelope', 'Antelope')
SET IDENTITY_INSERT ComponentValue OFF

SET IDENTITY_INSERT DecisionTree ON
INSERT INTO DecisionTree(Id, ParentId, ComponentTypeId, ComponentValueId) VALUES (1, 0, 1, null)	-- root select
INSERT INTO DecisionTree(Id, ParentId, ComponentTypeId, ComponentValueId) VALUES (2, 1, 2, 2)	-- option predators
INSERT INTO DecisionTree(Id, ParentId, ComponentTypeId, ComponentValueId) VALUES (3, 1, 2, 3)	-- option herbivores
INSERT INTO DecisionTree(Id, ParentId, ComponentTypeId, ComponentValueId) VALUES (4, 2, 1, null)	-- select predators
INSERT INTO DecisionTree(Id, ParentId, ComponentTypeId, ComponentValueId) VALUES (5, 4, 2, 4)	-- option tiger		
INSERT INTO DecisionTree(Id, ParentId, ComponentTypeId, ComponentValueId) VALUES (6, 4, 2, 5)	-- option leon		
INSERT INTO DecisionTree(Id, ParentId, ComponentTypeId, ComponentValueId) VALUES (7, 3, 1, null)	-- select herbivores
INSERT INTO DecisionTree(Id, ParentId, ComponentTypeId, ComponentValueId) VALUES (8, 7, 2, 6)	-- option zebra		
INSERT INTO DecisionTree(Id, ParentId, ComponentTypeId, ComponentValueId) VALUES (9, 7, 2, 7)	-- option buffalo		
INSERT INTO DecisionTree(Id, ParentId, ComponentTypeId, ComponentValueId) VALUES (10, 7, 2, 8)	-- option antelope		
SET IDENTITY_INSERT DecisionTree OFF