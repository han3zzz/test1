<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
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
	<div class="container">
		<h1>Thêm user mới</h1>
		<f:form action="${pageContext.request.contextPath}/account/add"
			method="post" modelAttribute="data">

			<label for="exampleInputEmail1">Username * :</label>
			<f:input type="text" class="form-control" id="exampleInputEmail1"
				placeholder="Nhập username " name="username" path="username" />
			<f:errors style="color:red" path="username" element="div"></f:errors>
			<label for="exampleInputEmail1">Password * :</label>
			<f:input type="text" class="form-control" id="exampleInputEmail1"
				placeholder="Nhập password " name="password" path="password" />
			<f:errors style="color:red" path="password" element="div"></f:errors>
			<label for="exampleInputEmail1">Email * :</label>
			<f:input type="text" class="form-control" id="exampleInputEmail1"
				placeholder="Nhập email " name="email" path="email" />
			<f:errors style="color:red" path="email" element="div"></f:errors>
			<label for="exampleInputEmail1">Vai trò * :</label>
			<f:select class="form-control" id="exampleFormControlSelect1"
				name="role" path="role">
				<option value="0">Admin</option>
				<option value="1">Thành viên</option>
			</f:select>
			<br>
			<button type="submit" class="btn btn-danger">
				<i class="fa-solid fa-plus"></i> Thêm User
			</button>
		</f:form>
	</div>
	<br>
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