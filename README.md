# BÁO CÁO BÀI TẬP VỀ NHÀ 03: HỆ CSDL QUẢN LÝ CẦM ĐỒ

**Thông tin sinh viên:**
* **Họ và tên:** Nguyễn Phú Hưng
* **Mã sinh viên:** K235480106091
* **Lớp:** 59KMT
* **Giảng viên hướng dẫn:** Thầy Đỗ Duy Cốp

---

## MÔ TẢ QUÁ TRÌNH THỰC HIỆN

### Nhiệm vụ 1: Thiết kế CSDL (Chuẩn 3NF)
Trong phần này, em đã tiến hành tạo Database `QuanLyCamDo` và xây dựng 4 bảng cốt lõi: `KhachHang`, `HopDong`, `TaiSan`, và `LogGiaoDich`. Các bảng được liên kết với nhau qua Khóa ngoại (Foreign Key) để đảm bảo toàn vẹn dữ liệu.

<img width="975" height="548" alt="image" src="https://github.com/user-attachments/assets/d703f938-7278-4298-a74c-ad9d404e6466" />
*(Text mô tả ảnh: Code T-SQL tạo 4 bảng dữ liệu và kết quả chạy thành công)*

---

### Nhiệm vụ 2: Cài đặt SQL (Store Procedure & Function)
Em đã viết các kịch bản để xử lý nghiệp vụ chính của hệ thống:
1. **Event 1 (Tạo hợp đồng mới):** Viết SP `sp_TaoHopDong` nhận đầu vào là chuỗi JSON để có thể thêm nhiều tài sản cùng lúc vào một hợp đồng, đồng thời tự động tính toán `Deadline1` và `Deadline2`.
<img width="975" height="548" alt="image" src="https://github.com/user-attachments/assets/ce0207df-bc42-4429-8e5e-2b067cdfe494" />

2. **Event 2 (Tính toán công nợ):** Viết Function `fn_CalcMoneyContract` sử dụng vòng lặp `WHILE` để xử lý chính xác bài toán dòng tiền: tính Lãi đơn trước Deadline 1 và tính Lãi kép cộng dồn gốc sau Deadline 1.
<img width="975" height="548" alt="image" src="https://github.com/user-attachments/assets/a95d35aa-61bf-4715-a1a5-207ea4205b52" />

3. **Event 3 (Xử lý trả nợ):** Viết SP `sp_XuLyTraNo` để xử lý logic trừ tiền, lưu log dòng tiền và gợi ý trả lại tài sản cho khách nếu định giá đồ còn lại lớn hơn dư nợ.
<img width="975" height="548" alt="image" src="https://github.com/user-attachments/assets/911369de-f667-467c-adb7-acf68df0abce" />

*(Text mô tả ảnh: Cài đặt Function tính lãi kép bằng vòng lặp và Store Procedure xử lý trả nợ)*

---

### Nhiệm vụ 3: Truy vấn danh sách nợ xấu (Event 4)
Em đã tạo một View `vw_BaoCaoNoXau` để lọc ra các khách hàng quá hạn Deadline 1. View này gọi lại Function tính tiền ở Nhiệm vụ 2 để hiển thị tổng nợ thực tế và dự đoán tổng nợ sau 1 tháng nữa.

<img width="975" height="548" alt="image" src="https://github.com/user-attachments/assets/c47efa9e-3fd3-4721-903a-50506c777f5a" />
*(Text mô tả ảnh: Cấu trúc View lấy danh sách nợ khó đòi)*

---

### Nhiệm vụ 4: Quản lý thanh lý tài sản bằng Trigger (Event 5)
Em đã viết Trigger gắn vào bảng `HopDong`. Khi hợp đồng bị cập nhật trạng thái thành "Đã thanh lý", Trigger sẽ tự động cập nhật tất cả tài sản thuộc hợp đồng đó sang trạng thái "Đã bán thanh lý".

<img width="975" height="548" alt="image" src="https://github.com/user-attachments/assets/3705e4db-dc6c-4ce1-8821-71aca72bc35f" />
*(Text mô tả ảnh: Đoạn code Trigger tự động hóa trạng thái tài sản)*

---

### Nhiệm vụ 5: Chạy kiểm thử (Dummy Data & Test Cases)
<img width="975" height="548" alt="image" src="https://github.com/user-attachments/assets/0a5d9d32-301d-4812-9a6d-753d4dd36aa8" />

Dưới đây là các ảnh chụp màn hình chứng minh hệ thống hoạt động đúng logic sau khi được nạp dữ liệu mẫu:

**1. Kịch bản tạo hợp đồng:**
<img width="975" height="548" alt="image" src="https://github.com/user-attachments/assets/688c4413-c65a-4b68-b3c9-b62771f126a4" />
*(Text mô tả ảnh: Hệ thống nhận diện 2 tài sản qua JSON và tạo hợp đồng thành công)*

**2. Kịch bản Báo cáo nợ xấu:**
<img width="975" height="548" alt="image" src="https://github.com/user-attachments/assets/d4b6f06c-7cfc-4948-9fc2-c09b4e7f1b11" />
*(Text mô tả ảnh: Hiển thị danh sách khách nợ xấu với số tiền lãi kép tăng chính xác)*

**3. Khách đến trả góp 1 phần:**
<img width="975" height="548" alt="image" src="https://github.com/user-attachments/assets/85a9e29a-1ad5-487d-8cee-59058fd93a80" />

**4. Kịch bản Trả góp và Tất toán:**
<img width="975" height="548" alt="image" src="https://github.com/user-attachments/assets/2f0aad0f-a156-4516-9946-14b6fd26442c" />
*(Text mô tả ảnh: Hệ thống ghi nhận dòng tiền trả góp vào Log và trả lại đồ khi tất toán đủ tiền)*

**5. Kịch bản Thanh lý tài sản:**
<img width="975" height="548" alt="image" src="https://github.com/user-attachments/assets/ff458910-cb2f-4e8d-8b44-3bd245fb7d41" />
*(Text mô tả ảnh: Trigger tự động chuyển trạng thái tài sản thành "Đã bán thanh lý" khi cập nhật hợp đồng)*
