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

<%@ include file="/html/portlet/message_boards/init.jsp" %>

<%
String topLink = ParamUtil.getString(request, "topLink", "message-boards-home");

MBCategory category = (MBCategory)request.getAttribute(WebKeys.MESSAGE_BOARDS_CATEGORY);

long categoryId = MBUtil.getCategoryId(request, category);

boolean viewCategory = GetterUtil.getBoolean((String)request.getAttribute("view.jsp-viewCategory"));

PortletURL portletURL = renderResponse.createRenderURL();

portletURL.setParameter("struts_action", "/message_boards/view");

%>

<div class="top-links-container">
	<div class="top-links">
		<div class="top-links-navigation">

			<%
			portletURL.setParameter("topLink", "message-boards-home");
			%>

			<liferay-ui:icon
				cssClass="top-link"
				image="../aui/home"
				label="<%= true %>"
				message="message-boards-home"
				url='<%= (topLink.equals("message-boards-home") && categoryId == 0 && viewCategory) ? StringPool.BLANK : portletURL.toString() %>'
			/>

			<%
			portletURL.setParameter("topLink", "recent-posts");
			%>

			<liferay-ui:icon
				cssClass="top-link"
				image="../aui/clock"
				label="<%= true %>"
				message="recent-posts"
				url='<%= topLink.equals("recent-posts") ? StringPool.BLANK : portletURL.toString() %>'
			/>

			<c:if test="<%= themeDisplay.isSignedIn() %>">

				<%
				portletURL.setParameter("topLink", "my-posts");
				%>

				<liferay-ui:icon
					cssClass="top-link"
					image="../aui/person"
					label="<%= true %>"
					message="my-posts"
					url='<%= topLink.equals("my-posts") ? StringPool.BLANK : portletURL.toString() %>'
				/>

				<%
				portletURL.setParameter("topLink", "my-subscriptions");
				%>

				<c:if test="<%= bShowSubscriptions %>">

					<liferay-ui:icon
						cssClass="top-link"
						image="../aui/signal-diag"
						label="<%= true %>"
						message="my-subscriptions"
						url='<%= topLink.equals("my-subscriptions") ? StringPool.BLANK : portletURL.toString() %>'
					/>
				
				</c:if>
				
			</c:if>

			<%
			portletURL.setParameter("topLink", "statistics");
			%>

			<c:if test="<%= bShowStatistics %>">

				<liferay-ui:icon
					cssClass='<%= "top-link" + (MBPermission.contains(permissionChecker, scopeGroupId, ActionKeys.BAN_USER) ? StringPool.BLANK : " last") %>'
					image="../aui/clipboard" label="<%= true %>"
					message="statistics"
					url='<%= topLink.equals("statistics") ? StringPool.BLANK : portletURL.toString() %>'
				/>

			</c:if>

			<c:if test="<%= MBPermission.contains(permissionChecker, scopeGroupId, ActionKeys.BAN_USER) %>">

				<%
				portletURL.setParameter("topLink", "banned-users_pa-custom");
				%>

				<liferay-ui:icon
					cssClass="top-link last"
					image="../aui/alert" label="<%= true %>"
					message="banned-users_pa-custom"
					url='<%= topLink.equals("banned-users") ? StringPool.BLANK : portletURL.toString() %>'
				/>
			</c:if>
		</div>

		<c:if test="<%= showSearch %>">
			<liferay-portlet:renderURL varImpl="searchURL">
				<portlet:param name="struts_action" value="/message_boards/search" />
			</liferay-portlet:renderURL>

			<div class="category-search">
				<aui:form action="<%= searchURL %>" method="get" name="searchFm">
					<liferay-portlet:renderURLParams varImpl="searchURL" />
					<aui:input name="redirect" type="hidden" value="<%= currentURL %>" />
					<aui:input name="breadcrumbsCategoryId" type="hidden" value="<%= categoryId %>" />
					<aui:input name="searchCategoryId" type="hidden" value="<%= categoryId %>" />

					<span class="aui-search-bar">
						<aui:input id="keywords1" inlineField="<%= true %>" label="" name="keywords" size="30" title="search-messages_pa-custom" type="text" />

						<aui:button type="submit" value="search" />
					</span>
				</aui:form>
			</div>

			<c:if test="<%= windowState.equals(WindowState.MAXIMIZED) && !themeDisplay.isFacebook() %>">
				<aui:script>
					Liferay.Util.focusFormField(document.<portlet:namespace />searchFm.<portlet:namespace />keywords);
				</aui:script>
			</c:if>
		</c:if>
	</div>
</div>