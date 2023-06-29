<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>HanLuxury</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath }/views/css/style.css">
      <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://kit.fontawesome.com/999051c9de.js" crossorigin="anonymous"></script>
</head>
<body>
<jsp:include page="common/_header.jsp"></jsp:include>
<c:if test="${not empty message}">
   						<input type="hidden" id="message" value="${message }">
                        <input type="hidden" id="type" value="${type }">
						</c:if>
 <h1 class="giua"> Đơn Hàng Của Tôi</h1>
      <br>
      <table class="table">
      <tr>
      <td>ID Hóa Đơn</td>
       <td>Ngày Mua</td>
       <td>Người Nhận</td>
       <td>SĐT</td>
       <td>Địa Chỉ</td>
       <td>Trạng Thái</td>
       <td>Hành Động</td>
      </tr>
      <c:forEach items="${listHoaDon }" var="p">
      <tr>
      <td>${p.idHoaDon }</td>
       <td>${p.ngayTao }</td>
       <td>${p.nguoiNhan }</td>
       <td>${p.soDienThoai }</td>
       <td>${p.diaChi }</td>
       <td>
       <c:if test="${p.trangThai == 0 }"><p style="color:green;"><i class="fa-solid fa-circle-check"></i> Đặt hàng thành công</p></c:if>
       <c:if test="${p.trangThai == 1 }"><p style="color:red;"><i class="fa-solid fa-circle-minus"></i> Đã hủy</p></c:if>
       <c:if test="${p.trangThai == 2 }"><p style="color:blue;"><i class="fa-solid fa-thumbs-up"></i> Đã giao hàng</p></c:if>
       </td>
       <td>
       	<c:if test="${p.trangThai !=0 }">
     	 <button class="btn btn-info"><a style="color: white; text-decoration: none;"  href="${pageContext.request.contextPath }/my-order/chitiet/${p.idHoaDon }" >Chi Tiết</a></button>
     	</c:if>
     	 <c:if test="${p.trangThai == 0 }">
     	 <button class="btn btn-info"><a style="color: white; text-decoration: none;"  href="${pageContext.request.contextPath }/my-order/chitiet/${p.idHoaDon }" >Chi Tiết</a></button>
     	 <button class="btn btn-danger"><a style="color: white; text-decoration: none;" href="${pageContext.request.contextPath }/my-order/huy/${p.idHoaDon }">Hủy</a></button></c:if>
       </td>
      </tr>
      </c:forEach>
      </table>
      <nav aria-label="Page navigation example">
         
                  <ul class="pagination">
                  <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath }/my-order">1</a></li>
                  <c:forEach begin="2" end="${count }"  var="i">
                  <li class="page-item"><a class="page-link" href="?pageNum=${i}">${i }</a></li>
                  </c:forEach>
   
  </ul>
</nav>
 

<jsp:include page="common/_footer.jsp"></jsp:include>
<script type="text/javascript">
		var message = document.getElementById("message").value;
		var type = document.getElementById("type").value;
		if(message != ""){
			Swal.fire(message, '', type);
		}
		
</script>
</body>
</html>