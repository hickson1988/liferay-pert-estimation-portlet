<!-- Tags -->
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x" %>

<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui" %>
<%@ taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet" %>
<%@ taglib uri="http://liferay.com/tld/security" prefix="liferay-security" %>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>
<%@ taglib uri="http://liferay.com/tld/util" prefix="liferay-util" %>

<!-- Imports -->
<%@ page import="java.security.Principal" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.Map.Entry"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.text.DecimalFormat" %>

<%@ page import="javax.portlet.ActionRequest"%>
<%@ page import="javax.portlet.PortalContext" %>
<%@ page import="javax.portlet.PortletMode" %>
<%@ page import="javax.portlet.PortletPreferences" %>
<%@ page import="javax.portlet.PortletSession" %>
<%@ page import="javax.portlet.PortletURL" %>
<%@ page import="javax.portlet.ResourceURL" %>
<%@ page import="javax.portlet.WindowState" %>

<%@ page import="com.liferay.portal.kernel.util.StringUtil"%>
<%@ page import="com.liferay.portal.kernel.dao.search.ResultRow" %>
<%@ page import="com.liferay.portal.kernel.dao.search.RowChecker" %>
<%@ page import="com.liferay.portal.kernel.dao.search.SearchContainer" %>
<%@ page import="com.liferay.portal.kernel.dao.search.SearchEntry" %>
<%@ page import="com.liferay.portal.kernel.language.LanguageUtil" %>
<%@ page import="com.liferay.portal.kernel.exception.SystemException" %>
<%@ page import="com.liferay.portal.kernel.log.Log" %>
<%@ page import="com.liferay.portal.kernel.log.LogFactoryUtil" %>
<%@ page import="com.liferay.portal.kernel.portlet.LiferayPortletSession" %>
<%@ page import="com.liferay.portal.kernel.portlet.LiferayWindowState" %>
<%@ page import="com.liferay.portal.kernel.servlet.SessionErrors" %>
<%@ page import="com.liferay.portal.kernel.util.ArrayUtil" %>
<%@ page import="com.liferay.portal.kernel.util.CalendarFactoryUtil" %>
<%@ page import="com.liferay.portal.kernel.util.Constants" %>
<%@ page import="com.liferay.portal.kernel.util.GetterUtil" %>
<%@ page import="com.liferay.portal.kernel.util.HtmlUtil" %>
<%@ page import="com.liferay.portal.kernel.util.HttpUtil" %>
<%@ page import="com.liferay.portal.kernel.util.URLStringEncoder" %>
<%@ page import="com.liferay.portal.kernel.util.KeyValuePair" %>
<%@ page import="com.liferay.portal.kernel.util.ListUtil" %>
<%@ page import="com.liferay.portal.kernel.util.KeyValuePairComparator" %>
<%@ page import="com.liferay.portal.kernel.util.LocalizationUtil" %>
<%@ page import="com.liferay.portal.kernel.util.OrderByComparator" %>
<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>
<%@ page import="com.liferay.portal.kernel.util.PropsKeys" %>
<%@ page import="com.liferay.portal.kernel.util.PropsUtil" %>
<%@ page import="com.liferay.portal.kernel.util.SetUtil" %>
<%@ page import="com.liferay.portal.kernel.util.StringPool" %>
<%@ page import="com.liferay.portal.kernel.util.PrefsParamUtil" %>
<%@ page import="com.liferay.portal.kernel.util.StringUtil" %>
<%@ page import="com.liferay.portal.kernel.util.Validator" %>
<%@ page import="com.liferay.portal.kernel.util.WebKeys" %>
<%@ page import="com.liferay.portal.model.Layout" %>
<%@ page import="com.liferay.portal.security.permission.ActionKeys" %>
<%@ page import="com.liferay.portal.service.permission.PortalPermissionUtil" %>
<%@ page import="com.liferay.portal.service.permission.PortletPermissionUtil" %>
<%@ page import="com.liferay.portal.service.LayoutLocalServiceUtil" %>
<%@ page import="com.liferay.portal.service.UserLocalServiceUtil" %>
<%@ page import="com.liferay.portal.util.PortalUtil" %>
<%@ page import="com.liferay.portlet.documentlibrary.service.DLFileEntryLocalServiceUtil" %>
<%@ page import="com.liferay.portlet.PortletURLUtil" %>
<%@ page import="com.liferay.portlet.PortletPreferencesFactoryUtil" %>
<%@ page import="com.liferay.util.portlet.PortletProps" %>
<%@ page import="com.portlet.estimationcalculator.beans.Task" %>

<portlet:defineObjects/> 
<liferay-theme:defineObjects/>