<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
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
    <br>
   <div class="container" >
    <div class="row">
        <div class="col-md-6">
            <div id="carouselExampleIndicators" class="carousel slide detail-giantrai" data-ride="carousel">
                <ol class="carousel-indicators">
                  <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                  <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                  <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                </ol>
                <div class="carousel-inner">
                  <div class="carousel-item active anhsp-detail">
                    <img class="d-block w-100" src="${pageContext.request.contextPath}/views/img/${p.anh}" alt="First slide">
                  </div>
                  <div class="carousel-item anhsp-detail">
                    <img class="d-block w-100" src="${pageContext.request.contextPath}/views/img/${p.anh}" alt="Second slide">
                  </div>
                  <div class="carousel-item anhsp-detail">
                    <img class="d-block w-100" src="${pageContext.request.contextPath}/views/img/${p.anh}" alt="Third slide">
                  </div>
                </div>
                <a class="carousel-control-prev" role="button" data-slide="prev">
                 
                  <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" role="button" data-slide="next">
                 
                  <span class="sr-only">Next</span>
                </a>
              </div>
        </div>
        <div class="col-md-6">
        
        	<f:form action="${pageContext.request.contextPath }/detail/${p.id }" method="post" modelAttribute="data" enctype="multipart/form-data">
        	<f:input type="hidden" name="username" value="${account.username }" path="username"/>
        	<f:input type="hidden" name="idProduct" value="${p.id }" path="idProduct"/>
        	<f:input type="hidden" name="dongia" value="${p.giaDaGiam }" path="dongia"/>
            <div class="tieude">${fn:toUpperCase(p.tieuDe) }</div>
          
            <div class="detail-indam"><span>Tình trạng : 
              <c:if test="${count > 0}"><span style="color: green">Còn hàng</span></c:if>
              <c:if test="${count < 1}"><span style="color: red">Hết hàng</span></c:if>
            </span> 
             
              
            </div>
            <div class="inline detail-giamgia"><div class="gia inline"><fmt:formatNumber>${p.giaDaGiam}</fmt:formatNumber> VNĐ
              <div class="gia inline" ></div><p class="gach"><c:if test="${p.giamGia > 0 }">- <fmt:formatNumber>${p.giamGia}</fmt:formatNumber> % </c:if></p></div></div>
             <div class="detail-indam"><span>Số lượng :</span> 
             <c:forEach items="${listKT }" var="kt">
             <span>[ ${kt.kichThuoc.tenKichThuoc} : ${kt.soLuong } ]</span>
                </c:forEach>
            </div>
            <div class="detail-indam"><span>Kích thước :</span>
                <br>
                <c:forEach items="${listKT }" var="kt">
               <c:if test="${kt.soLuong > 0 }">
               <f:radiobutton name="kichThuoc" value="${kt.kichThuoc.idKichThuoc }" path="kichthuoc"/>${kt.kichThuoc.tenKichThuoc }</>
               </c:if>
                </c:forEach>
                 
    
            
           
            </div>
           
            <div class="detail-indam"><span>Mô tả :</span> ${p.moTa }</div>
            <div class="detail-indam"><span>Chất liệu :</span> ${p.chatLieu }</div>
            <div class="detail-indam"><span>Thiết kế :</span> ${p.thietKe }</div>
            <br>
            <div class="themvaogio">
                <button class="nutthemgio-detail" type="submit"><a href="#"><i class="fa-solid fa-cart-shopping"></i><p class="gian">Thêm vào giỏ hàng</p></a></button>
            </div>
            <br>
            <div class="doitra">
                <div class="doitra-tieude">Đổi Trả Miễn Phí</div>
                <span><i class="fa-solid fa-check"></i> Trong vòng 30 ngày bất cứ lỗi sản phẩm</span><br>
                <span><i class="fa-solid fa-check"></i> Có bưu tá tới tận nơi để lấy hàng</span><br>
                <span><i class="fa-solid fa-check"></i> Vui lòng liên hệ để được hỗ trợ đổi trả nhanh nhất</span>
            </div>
        	</f:form>
        </div>
    </div>
   </div>
   <br>
   <br>
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