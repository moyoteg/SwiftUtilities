import Foundation

public enum SwiftUtilities {
    
    public static func isRunningFromXcodeDebugger() -> Bool {

        var info = kinfo_proc()
        var mib : [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]
        var size = MemoryLayout<kinfo_proc>.stride
        let junk = sysctl(&mib, UInt32(mib.count), &info, &size, nil, 0)
        assert(junk == 0, "sysctl failed")
        return (info.kp_proc.p_flag & P_TRACED) != 0
    }
    
    public enum VersionError: Error {
        case invalidBundleInfo
        case invalidResponse
    }
    
    public static func isAppStoreVersion(completion: @escaping (Bool?, Error?) -> Void) throws -> URLSessionDataTask {
        guard let info = Bundle.main.infoDictionary,
          let currentVersion = info["CFBundleShortVersionString"] as? String,
          let identifier = info["CFBundleIdentifier"] as? String else {
            throw VersionError.invalidBundleInfo
        }
        let urlString = "https://itunes.apple.com/gb/lookup?bundleId=\(identifier)"
        guard let url = URL(string:urlString) else { throw VersionError.invalidBundleInfo }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
          do {
            if let error = error { throw error }
            guard let data = data else { throw VersionError.invalidResponse }
            let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any]
            guard let result = (json?["results"] as? [Any])?.first as? [String: Any], let appStoreVersion = result["version"] as? String else {
              throw VersionError.invalidResponse
            }
            completion(appStoreVersion == currentVersion, nil)
          } catch {
            completion(nil, error)
          }
        }
        task.resume()
        return task
    }
    
}
