ALTER TABLE store
    ADD FOREIGN KEY (manager_staff_id) REFERENCES staff (staff_id);