<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js"
	integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/views/css/style.css">
<script src="https://kit.fontawesome.com/999051c9de.js"
	crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
	<jsp:include page="../common/_header.jsp"></jsp:include>
	<c:if test="${not empty message}">
		<input type="hidden" id="message" value="${message }">
		<input type="hidden" id="type" value="${type }">
	</c:if>
	<h1 style="text-align: center;">Quản lý sản phẩm</h1>
	<br>
	<div class="btnThem">
		<button type="button" class="btn btn-secondary">
			<a href="${pageContext.request.contextPath }/admin/add"><i
				class="fa-solid fa-circle-plus"></i> Thêm sản phẩm</a>
		</button>
	</div>
	<br>
	<table class="table">
		<tr>
			<td>ID</td>
			<td>Ảnh</td>
			<td>Tiêu đề</td>
			<td>Giá</td>
			<!-- <td>Số lượng</td> -->
			<td>Chức năng</td>
		</tr>
		<c:forEach items="${list }" var="p">
			<tr>
				<td>${p.id }</td>
				<td><img
					src="${pageContext.request.contextPath }/views/img/${p.anh}"
					height="100" width="100"></td>
				<td>${p.tieuDe }</td>
				<td>${p.gia }</td>
				<%-- <td>${p.soLuong }</td> --%>
				<td>
					<button type="button" class="btn btn-danger btnSua">
						<a
							href="${pageContext.request.contextPath }/admin/update/${p.id }"><i
							class="fa-solid fa-wrench"></i> Sửa</a>
					</button>
					<button type="button" class="btn btn-warning btnSua">
						<a
							href="${pageContext.request.contextPath }/admin/delete/${p.id }"><i
							class="fa-solid fa-trash"></i> Xóa</a>
					</button>
				</td>
			</tr>
		</c:forEach>
		<!-- Modal -->

	</table>
	<nav aria-label="Page navigation example">

		<ul class="pagination">
			<li class="page-item"><a class="page-link" href="admin">1</a></li>
			<c:forEach begin="2" end="${count }" var="i">
				<li class="page-item"><a class="page-link" href="?pageNum=${i}">${i }</a></li>
			</c:forEach>

		</ul>
	</nav>
	<jsp:include page="../common/_footer.jsp"></jsp:include>
			<script type="text/javascript">
		var message = document.getElementById("message").value;
		var type = document.getElementById("type").value;
		if(message != ""){
			console.log("ggk");
			Swal.fire(message, '', type);
		}
		
</script>
</body>
</html>