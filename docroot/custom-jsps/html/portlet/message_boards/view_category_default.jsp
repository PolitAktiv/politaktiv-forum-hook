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
MBCategory category = (MBCategory)request.getAttribute(WebKeys.MESSAGE_BOARDS_CATEGORY);

long categoryId = MBUtil.getCategoryId(request, category);

MBCategoryDisplay categoryDisplay = (MBCategoryDisplay)request.getAttribute("view.jsp-categoryDisplay");

Set<Long> categorySubscriptionClassPKs = (Set<Long>)request.getAttribute("view.jsp-categorySubscriptionClassPKs");
Set<Long> threadSubscriptionClassPKs = (Set<Long>)request.getAttribute("view.jsp-threadSubscriptionClassPKs");

PortletURL portletURL = (PortletURL)request.getAttribute("view.jsp-portletURL");

if ((category != null) && layout.isTypeControlPanel()) {
	MBUtil.addPortletBreadcrumbEntries(category, request, renderResponse);
}
%>

<liferay-ui:panel-container cssClass="message-boards-panels" extended="<%= false %>" id="messageBoardsPanelContainer" persistState="<%= true %>">

	<%
	int categoriesCount = MBCategoryServiceUtil.getCategoriesCount(scopeGroupId, categoryId, WorkflowConstants.STATUS_APPROVED);
	%>

	<c:if test="<%= categoriesCount > 0 %>">
		<liferay-ui:panel collapsible="<%= categoriesPanelCollapsible %>" extended="<%= categoriesPanelExtended %>" id="messageBoardsCategoriesPanel" persistState="<%= true %>" title='<%= LanguageUtil.get(pageContext, (category != null) ? "subcategories_pa-custom[message-board]" : "categories_pa-custom[message-board]") %>'>
			<liferay-ui:search-container
				curParam="cur1"
				deltaConfigurable="<%= false %>"
				headerNames="category[message-board],categories[message-board],threads,posts"
				iteratorURL="<%= portletURL %>"
				total="<%= categoriesCount %>"
			>
				<liferay-ui:search-container-results
					results="<%= MBCategoryServiceUtil.getCategories(scopeGroupId, categoryId, WorkflowConstants.STATUS_APPROVED, searchContainer.getStart(), searchContainer.getEnd()) %>"
				/>

				<liferay-ui:search-container-row
					className="com.liferay.portlet.messageboards.model.MBCategory"
					escapedModel="<%= true %>"
					keyProperty="categoryId"
					modelVar="curCategory"
				>
					<liferay-ui:search-container-row-parameter name="categorySubscriptionClassPKs" value="<%= categorySubscriptionClassPKs %>" />

					<liferay-portlet:renderURL varImpl="rowURL">
						<portlet:param name="struts_action" value="/message_boards/view" />
						<portlet:param name="mbCategoryId" value="<%= String.valueOf(curCategory.getCategoryId()) %>" />
					</liferay-portlet:renderURL>

					<%@ include file="/html/portlet/message_boards/category_columns.jspf" %>
				</liferay-ui:search-container-row>

				<liferay-ui:search-iterator />
			</liferay-ui:search-container>
		</liferay-ui:panel>
	</c:if>

	<liferay-ui:panel collapsible="<%= threadsPanelCollapsible %>" cssClass="threads-panel" extended="<%= threadsPanelExtended %>" id="messageBoardsThreadsPanel" persistState="<%= true %>" title='<%= LanguageUtil.get(pageContext, "threads_pa-custom") %>'>
		<liferay-ui:search-container
			curParam="cur2"
			emptyResultsMessage="there-are-no-threads-in-this-category_pa-custom"
			headerNames="thread_pa-custom,flag,started-by,posts_pa-custom,views,last-post"
			iteratorURL="<%= portletURL %>"
			total="<%= MBThreadServiceUtil.getThreadsCount(scopeGroupId, categoryId, WorkflowConstants.STATUS_APPROVED) %>"
		>
			<liferay-ui:search-container-results
				results="<%= MBThreadServiceUtil.getThreads(scopeGroupId, categoryId, WorkflowConstants.STATUS_APPROVED, searchContainer.getStart(), searchContainer.getEnd()) %>"
			/>

			<liferay-ui:search-container-row
				className="com.liferay.portlet.messageboards.model.MBThread"
				keyProperty="threadId"
				modelVar="thread"
			>

				<%
				MBMessage message = null;

				try {
					message = MBMessageLocalServiceUtil.getMessage(thread.getRootMessageId());
				}
				catch (NoSuchMessageException nsme) {
					_log.error("Thread requires missing root message id " + thread.getRootMessageId());

					message = new MBMessageImpl();

					row.setSkip(true);
				}

				message = message.toEscapedModel();

				row.setBold(!MBThreadFlagLocalServiceUtil.hasThreadFlag(themeDisplay.getUserId(), thread));
				row.setObject(new Object[] {message, threadSubscriptionClassPKs});
				row.setRestricted(!MBMessagePermission.contains(permissionChecker, message, ActionKeys.VIEW));
				%>

				<liferay-portlet:renderURL varImpl="rowURL">
					<portlet:param name="struts_action" value="/message_boards/view_message" />
					<portlet:param name="messageId" value="<%= String.valueOf(message.getMessageId()) %>" />
				</liferay-portlet:renderURL>

				<%@ include file="/html/portlet/message_boards/thread_columns.jspf" %>
			</liferay-ui:search-container-row>

			<liferay-ui:search-iterator />
		</liferay-ui:search-container>
	</liferay-ui:panel>
</liferay-ui:panel-container>

<%!
private static Log _log = LogFactoryUtil.getLog("portal-web.docroot.html.portlet.message_boards.view_category_default_jsp");
%>