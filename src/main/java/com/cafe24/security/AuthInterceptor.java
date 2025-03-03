package com.cafe24.security;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.cafe24.mysite.vo.UserVo;

public class AuthInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// 1. handler 종류 확인
		if (handler instanceof HandlerMethod == false) {
			return true;
		}

		// 2. casting
		HandlerMethod handlerMethod = (HandlerMethod) handler;

		// 3. Method의 @Auth 받아오기
		Auth auth = handlerMethod.getMethodAnnotation(Auth.class);

		// 4. Method에 @Auth 없으면
		// Class(Type)에 @Auth를 받아오기
		if (auth == null) {
			auth = handlerMethod.getMethod().getDeclaringClass().getAnnotation(Auth.class);
		}

		// 5. @Auth가 안붙어있는 경우
		if (auth == null) {
			return true;
		}

		// 6. @Auth가 (Class 또는 method에) 붙어있기 때문에 인증 여부 체크
		HttpSession session = request.getSession(false);
		UserVo authUser = (UserVo) session.getAttribute("authUser");

		if (session == null || authUser == null) { // 인증이 안되어 있음
			response.sendRedirect(request.getContextPath() + "/user/login");
			return false;
		}

		// 7. Role 가져오기
		Auth.Role role = auth.role();

		// 8. role이 Auth.Role.USER 라면, 인증된 모든 사용자는 접근 가능
		if (role == Auth.Role.USER) {
			return true;
		}

		// 9. ADMIN Role 권한 체크 (db에서 User의 role을 확인한다.)
		// authUser.getRole().equals("ADMIN")

		return true;
	}

}
