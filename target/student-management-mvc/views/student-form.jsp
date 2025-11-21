<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><c:choose><c:when test="${student != null}">Edit Student</c:when><c:otherwise>Add New Student</c:otherwise></c:choose></title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; display: flex; justify-content: center; align-items: center; padding: 20px; }
        .container { background: white; border-radius: 10px; padding: 40px; width: 100%; max-width: 600px; box-shadow: 0 10px 40px rgba(0,0,0,0.2); }
        h1 { color: #333; margin-bottom: 30px; text-align: center; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; color: #555; font-weight: 500; }
        input[type="text"], input[type="email"], select { width: 100%; padding: 12px; border: 2px solid #ddd; border-radius: 5px; font-size: 14px; }
        input:focus { border-color: #667eea; outline: none; }
        .btn { padding: 12px 24px; border: none; border-radius: 5px; font-size: 16px; cursor: pointer; text-decoration: none; display: inline-block; margin-right: 10px; color: white; }
        .btn-primary { background: #667eea; }
        .btn-secondary { background: #6c757d; }
        .info { font-size: 12px; color: #666; margin-top: 5px; }
        .error-msg { background: #f8d7da; color: #721c24; padding: 10px; border-radius: 5px; margin-bottom: 20px; }
    </style>
</head>
<body>
    <div class="container">
        <h1><c:choose><c:when test="${student != null}">✏️ Edit Student</c:when><c:otherwise>➕ Add New Student</c:otherwise></c:choose></h1>

        <c:if test="${not empty param.error}">
            <div class="error-msg">⚠️ ${param.error}</div>
        </c:if>

        <form action="student" method="POST">
            <input type="hidden" name="action" value="${student != null ? 'update' : 'insert'}">
            <c:if test="${student != null}"><input type="hidden" name="id" value="${student.id}"></c:if>

            <div class="form-group">
                <label>Student Code *</label>
                <input type="text" name="studentCode" value="${student.studentCode}" 
                       ${student != null ? 'readonly' : 'required'}>
                <p class="info">Format: 2 uppercase letters + 3 digits (e.g., SV001)</p>
            </div>

            <div class="form-group">
                <label>Full Name *</label>
                <input type="text" name="fullName" value="${student.fullName}" required>
            </div>

            <div class="form-group">
                <label>Email *</label>
                <input type="email" name="email" value="${student.email}" required>
            </div>

            <div class="form-group">
                <label>Major *</label>
                <select name="major" required>
                    <option value="">-- Select Major --</option>
                    <option value="Computer Science" ${student.major == 'Computer Science' ? 'selected' : ''}>Computer Science</option>
                    <option value="Information Technology" ${student.major == 'Information Technology' ? 'selected' : ''}>Information Technology</option>
                    <option value="Software Engineering" ${student.major == 'Software Engineering' ? 'selected' : ''}>Software Engineering</option>
                    <option value="Business Administration" ${student.major == 'Business Administration' ? 'selected' : ''}>Business Administration</option>
                </select>
            </div>

            <div style="text-align: center; margin-top: 30px;">
                <button type="submit" class="btn btn-primary">💾 Save</button>
                <a href="student?action=list" class="btn btn-secondary">❌ Cancel</a>
            </div>
        </form>
    </div>
</body>
</html>