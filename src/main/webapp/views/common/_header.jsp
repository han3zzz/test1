<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<header >
    <nav class="navbar navbar-expand-lg navbar-light nav">
      <a class="navbar-brand" href="index"><img class="logo" src="${pageContext.request.contextPath}/views/img/logo.png"></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
      
        <div class="collapse navbar-collapse" id="navbarSupportedContent" >
          <ul class="navbar-nav mr-auto">
            <li class="nav-item menu">
              <a class="chu-m" href="${pageContext.request.contextPath}/index"><i class="fa-solid fa-house"></i> Trang Chủ <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item menu">
              <a class="chu-m" href="${pageContext.request.contextPath}/product"><i class="fa-solid fa-bag-shopping"></i> Sản Phẩm</a>
            </li>
            <li class="nav-item menu">
              <a class="chu-m" href="${pageContext.request.contextPath}/info"><i class="fa-solid fa-circle-info"></i> Giới Thiệu</a>
            </li> 
    		<c:if test="${account.role ==0 }"><li class="nav-item menu">
              <a class="chu-m" href="${pageContext.request.contextPath}/manage"><i class="fa-solid fa-rocket"></i> Trang Quản Trị</a>
            </li>
             </c:if>
            
            
          </ul>
          <div class="button-cangiua">
         
          <button class="nut"><a class="nav-link menu" href="${pageContext.request.contextPath}/cart"><i class="fa-solid fa-cart-shopping"></i></a>
          
          </button>
          
          <button class="nuthan dropdown show">
            <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    <i class="fa-solid fa-user"></i> Hi , <c:if test="${account != null }">${account.username}</c:if>
    <c:if test="${account == null }">khách</c:if>
  </a>
  <c:choose>
  <c:when test="${account != null }">
  <div class="dropdown-menu drop" aria-labelledby="dropdownMenuLink">
    <div class="nutdrop">
    <a class="dropdown-item" href="${pageContext.request.contextPath}/my-order">Đơn hàng của tôi</a>
    <a class="dropdown-item" href="${pageContext.request.contextPath}/change">Đổi mật khẩu</a>
    <a class="dropdown-item" href="#" onclick="dangXuat()">Đăng xuất</a>
    </div>
  </div>
  </c:when>
  <c:otherwise>
  <div class="dropdown-menu drop" aria-labelledby="dropdownMenuLink">
    <div class="nutdrop">
    <a class="dropdown-item" href="${pageContext.request.contextPath}/login">Login</a>
    <a class="dropdown-item" href="${pageContext.request.contextPath}/register">Register</a>
    <a class="dropdown-item" href="${pageContext.request.contextPath}/forget">Forget Pass</a>
    </div>
  </div>
  </c:otherwise>
  </c:choose>
  
          </button>

          </div>
        </div>
      </nav>
  </header>
    <br>
    <script>
    	function dangXuat() {
    		Swal.fire({
    			  title: 'Bạn chắc chắn muốn đăng xuất?',
    			  showCancelButton: true,
    			  confirmButtonText: 'Đăng xuất',
    			}).then((result) => {
    			  /* Read more about isConfirmed, isDenied below */
    			  if (result.isConfirmed) {
    				  Swal.fire('Đăng xuất thành công !', '', 'success');
    				  setTimeout(() => {
    					  location.href = "${pageContext.request.contextPath}/logout";
					}, 2000);
    				
    			    
    			  } else if (result.isDenied) {
    			   
    			  }
    			})
		}
    	
    </script>