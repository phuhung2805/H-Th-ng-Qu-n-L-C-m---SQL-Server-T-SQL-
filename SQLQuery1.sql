-- Hợp đồng 2 (của Trần Thị B) nợ quá lâu. Quản lý quyết định thanh lý!
UPDATE HopDong 
SET TrangThai = N'Đã thanh lý' 
WHERE MaHD = 2;

-- Kiểm tra xem Macbook và iPhone đã tự động bị đem đi bán chưa (Nhờ Trigger)
SELECT TenTS, TrangThai FROM TaiSan WHERE MaHD = 2;