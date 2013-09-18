<%--
/**
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *        http://www.apache.org/licenses/LICENSE-2.0
 *        
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
 --%>

<%@ include file="/html/taglib/init.jsp" %>

<%
String icon = (String)request.getAttribute("liferay-ui:icon-menu:icon");
String id = (String)request.getAttribute("liferay-ui:icon-menu:id");
String message = (String)request.getAttribute("liferay-ui:icon-menu:message");
String align = (String)request.getAttribute("liferay-ui:icon-menu:align");
String cssClass = GetterUtil.getString((String)request.getAttribute("liferay-ui:icon-menu:cssClass"));
boolean showArrow = GetterUtil.getBoolean((String)request.getAttribute("liferay-ui:icon-menu:showArrow"));
boolean showExpanded = GetterUtil.getBoolean((String)request.getAttribute("liferay-ui:icon-menu:showExpanded"));
%>

<c:choose>
	<c:when test="<%= showExpanded %>">
		<div class="lfr-component lfr-menu-list lfr-menu-expanded <%= align %> <%= cssClass %>" id="<%= id %>menu">
	</c:when>
	<c:otherwise >
		<ul class='lfr-component lfr-actions <%= align %> <%= cssClass %> <%= showArrow ? "show-arrow" : StringPool.BLANK %>'>

			<li class="lfr-trigger">
				<strong>
					<a class="nobr" href="javascript:;">
						<c:if test="<%= Validator.isNotNull(icon) %>">
							<img alt="" src="<%= icon %>" />
						</c:if>
						<span class="mb-icon-menu-label">						
							<liferay-ui:message key="<%= message %>" />
						</span>
					</a>
				</strong>
	</c:otherwise>
</c:choose>

<ul>