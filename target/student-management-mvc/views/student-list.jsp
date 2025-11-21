<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student List - MVC</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; padding: 20px; }
        .container { max-width: 1200px; margin: 0 auto; background: white; border-radius: 10px; padding: 30px; box-shadow: 0 10px 40px rgba(0,0,0,0.2); }
        h1 { color: #333; margin-bottom: 10px; }
        .subtitle { color: #666; margin-bottom: 30px; font-style: italic; }
        .message { padding: 15px; margin-bottom: 20px; border-radius: 5px; font-weight: 500; }
        .success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .btn { display: inline-block; padding: 10px 20px; text-decoration: none; border-radius: 5px; border: none; cursor: pointer; font-size: 14px; transition: all 0.3s; }
        .btn-primary { background: #667eea; color: white; }
        .btn-secondary { background: #6c757d; color: white; }
        .btn-danger { background: #dc3545; color: white; padding: 8px 16px; }
        
        /* Table Styles */
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        thead { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #ddd; }
        th a { color: white; text-decoration: none; display: flex; align-items: center; gap: 5px; }
        th a:hover { text-decoration: underline; }
        
        /* Top Bar & Search */
        .top-bar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; flex-wrap: wrap; gap: 15px; }
        .search-form { display: flex; gap: 10px; }
        .search-input { padding: 10px; border: 1px solid #ddd; border-radius: 5px; width: 250px; }
        
        /* Pagination */
        .pagination { display: flex; justify-content: center; gap: 5px; margin-top: 30px; }
        .pagination a, .pagination span { padding: 8px 14px; border: 1px solid #ddd; text-decoration: none; color: #333; border-radius: 4px; }
        .pagination a:hover { background-color: #f0f0f0; }
        .pagination .active { background-color: #667eea; color: white; border-color: #667eea; }
        .pagination .disabled { color: #ccc; pointer-events: none; border-color: #eee; }
        
        .actions { display: flex; gap: 10px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>📚 Student Management System</h1>
        <p class="subtitle">MVC Pattern (Search, Pagination, Sorting & Validation)</p>
        
        <c:if test="${not empty param.message}"><div class="message success">✅ ${param.message}</div></c:if>
        <c:if test="${not empty param.error}"><div class="message error">❌ ${param.error}</div></c:if>
        
        <!-- Top Bar -->
        <div class="top-bar">
            <a href="student?action=new" class="btn btn-primary">➕ Add New Student</a>
            
            <form action="student" method="GET" class="search-form">
                <input type="hidden" name="action" value="list">
                <input type="text" name="keyword" class="search-input" 
                       placeholder="Search by name or code..." value="${param.keyword}">
                <button type="submit" class="btn btn-secondary">🔍 Search</button>
                <c:if test="${not empty param.keyword}">
                    <a href="student?action=list" class="btn btn-secondary">Clear</a>
                </c:if>
            </form>
        </div>
        
        <!-- Table -->
        <c:choose>
            <c:when test="${not empty students}">
                <table>
                    <thead>
                        <tr>
                            <c:set var="newSortOrder" value="${param.sortOrder eq 'ASC' ? 'DESC' : 'ASC'}" />
                            
                            <th><a href="student?action=list&page=1&keyword=${param.keyword}&sortBy=id&sortOrder=${newSortOrder}">ID ${param.sortBy == 'id' ? (param.sortOrder == 'ASC' ? '▲' : '▼') : ''}</a></th>
                            <th><a href="student?action=list&page=1&keyword=${param.keyword}&sortBy=studentCode&sortOrder=${newSortOrder}">Student Code ${param.sortBy == 'studentCode' ? (param.sortOrder == 'ASC' ? '▲' : '▼') : ''}</a></th>
                            <th><a href="student?action=list&page=1&keyword=${param.keyword}&sortBy=fullName&sortOrder=${newSortOrder}">Full Name ${param.sortBy == 'fullName' ? (param.sortOrder == 'ASC' ? '▲' : '▼') : ''}</a></th>
                            <th><a href="student?action=list&page=1&keyword=${param.keyword}&sortBy=email&sortOrder=${newSortOrder}">Email ${param.sortBy == 'email' ? (param.sortOrder == 'ASC' ? '▲' : '▼') : ''}</a></th>
                            <th><a href="student?action=list&page=1&keyword=${param.keyword}&sortBy=major&sortOrder=${newSortOrder}">Major ${param.sortBy == 'major' ? (param.sortOrder == 'ASC' ? '▲' : '▼') : ''}</a></th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="student" items="${students}">
                            <tr>
                                <td>${student.id}</td>
                                <td><strong>${student.studentCode}</strong></td>
                                <td>${student.fullName}</td>
                                <td>${student.email}</td>
                                <td>${student.major}</td>
                                <td>
                                    <div class="actions">
                                        <a href="student?action=edit&id=${student.id}" class="btn btn-secondary">✏️ Edit</a>
                                        <a href="student?action=delete&id=${student.id}" class="btn btn-danger" onclick="return confirm('Delete student ${student.studentCode}?')">🗑️ Delete</a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <!-- Pagination -->
                <div class="pagination">
                    <c:if test="${currentPage > 1}">
                        <a href="student?action=list&page=${currentPage - 1}&keyword=${keyword}&sortBy=${sortBy}&sortOrder=${sortOrder}">Previous</a>
                    </c:if>
                    
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <c:choose>
                            <c:when test="${currentPage eq i}">
                                <span class="active">${i}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="student?action=list&page=${i}&keyword=${keyword}&sortBy=${sortBy}&sortOrder=${sortOrder}">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    
                    <c:if test="${currentPage < totalPages}">
                        <a href="student?action=list&page=${currentPage + 1}&keyword=${keyword}&sortBy=${sortBy}&sortOrder=${sortOrder}">Next</a>
                    </c:if>
                </div>
            </c:when>
            <c:otherwise>
                <div style="text-align: center; padding: 50px; color: #888;">
                    <h3>No students found matching "${keyword}"</h3>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>