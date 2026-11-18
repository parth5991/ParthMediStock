CREATE TABLE InventoryBatches (
    BatchNum VARCHAR(20) PRIMARY KEY,
    MedID VARCHAR(10),
    ExpDate DATE NULL,
    QtyStock INT,
    FOREIGN KEY (MedID) REFERENCES Medicines(MedID)
);