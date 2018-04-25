/*:
 * NetworkTools.swift
 * Created by Weslie
 * Copyright © 2017 Weslie. All rights reserved.
 */

import AFNetworking

/// enumerate request method string
enum RequestMethod: String {
    case get = "get"
    case post = "post"
}

class NetworkTools: AFHTTPSessionManager {
    /// Create singleton. This is thread-safe
    static let shareInstance: NetworkTools = {

        let tools = NetworkTools()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        return tools
    }()
}

extension NetworkTools {
    /// Make alias for network request call back closure
    typealias requestCallbackType = (_ result: AnyObject?, _ error: Error?) -> Void
    
    func request(method: RequestMethod, urlString: String, parameters: Any?, finished: @escaping requestCallbackType) {
        
        /// Success or failure request call back closure
        let successCallback = { (task:  URLSessionDataTask, result: Any?) in
            finished(result as AnyObject, nil)
        }
        let failureCallback = { (task:  URLSessionDataTask?, error: Error) in
            finished(nil, error)
        }
        
        /// Implement request method
        if method == .get{
            get(urlString, parameters: parameters, progress: nil, success: successCallback, failure: failureCallback)
        } else if method == .post {
            post(urlString, parameters: parameters, progress: nil, success: successCallback, failure: failureCallback)
        }
    }
}

extension NetworkTools {
    /// Fuction call example
    func loadAccessToken(code: String, finished: @escaping (_ result: [String : AnyObject]?, _ error: Error?) -> Void) {
        /// type in request URL
        let urlString = "https://api.weibo.com/oauth2/access_token"
        
        /// Set value for HTTP request header if needed
        //self.requestSerializer.setValue(token, forHTTPHeaderField: "token")
        
        /// Store request parameters
        let parameters = ["client_id" : app_key, "client_secret" : app_secret, "grant_type" : "authorization_code", "redirect_uri" : redirect_uri, "code" : code]
        
        /// Make network request
        request(method: .post, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> Void in
            /// request succeeded
            guard let resultDict = result as? [String: AnyObject] else {
                finished(nil, error)
                return
            }
            /// call back to outside view controller
            finished(resultDict, error)
        }
    }
}
