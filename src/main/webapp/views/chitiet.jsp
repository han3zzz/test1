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
 <div class="container">
 <h1 class="giua"> Chi Tiết Đơn Hàng #${id }</h1>
      <br>
      <table class="table">
      <tr>
      <td>Tên sản phẩm</td>
       <td>Kích thước</td>
       <td>Số lượng</td>
       <td>Đơn giá</td>
      </tr>
     <c:forEach items="${list }" var="p">
      <tr>
      <td>${p.product.tieuDe }</td>
       <td>${p.kichThuoc }</td>
       <td>${p.soLuong }</td>
       <td>${p.donGia }</td>
      </tr>
     </c:forEach>
      
      </table>
      <button class="btn btn-info"><a style="color: white;text-decoration: none;" href="${pageContext.request.contextPath }/my-order">Trở lại</a></button>
      
 </div>
 <br>

<jsp:include page="common/_footer.jsp"></jsp:include>
<!-- Modal -->

</body>
</html>