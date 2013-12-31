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


<%
/* Note: Under Liferay 6.1, we had two additional variables here:
    boolean rssGlobalActionEnabled 			= true;
	boolean rssThreadActionEnabled 		 	= false;
	Liferay now implements this by its own, variable is called "enableRSS", see also init.jsp
*/


boolean bShowCatCountInCatList    		= false;
boolean bShowThreadCountInCatList 		= false;

boolean bShowStatistics 		 		= false;

boolean bShowEditMsgPermSection			= false;
boolean bShowSubscriptions 	 			= false; // may be deprecated


// variables seem to be deprecated in 6.2 

boolean bShowThreadNumberCol 			= false;
boolean bShowThreadViewsCol  			= false;


// not even used any more 
boolean bUserDisplayShowRank 			= false;
boolean bUserDisplayShowJoinDate 		= false;



--%>