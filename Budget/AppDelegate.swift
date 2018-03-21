//  Copyright (c) 2017 Lighthouse Labs. All rights reserved.
//
// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
// distribute, sublicense, create a derivative work, and/or sell copies of the
// Software in any work that is designed, intended, or marketed for pedagogical or
// instructional purposes related to programming, coding, application development,
// or information technology.  Permission for such use, copying, modification,
// merger, publication, distribution, sublicensing, creation of derivative works,
// or sale is expressly withheld.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func applicationDidFinishLaunching(_ application: UIApplication) {
    let database = DataManager()
    database.openDatabase()
    database.initialSetup()
    
    //    let database = SQLiteDatabase()
//    try? database.openDatabase(name: "test-database.db")
//    try? database.execute(simpleQuery: """
//      CREATE TABLE "users" (
//          id INTEGER PRIMARY KEY NOT NULL,
//          name TEXT,
//          email TEXT NOT NULL UNIQUE
//      );
//      """)
//    try? database.execute(simpleQuery: """
//        INSERT INTO users (name, email)
//        VALUES ('Larry', 'larry@lighthouselabs.com'),
//        ('Madam Brexit', 'theresa-mary-@netscape.net'),
//        ('Trumpty Dumpty', 'the-trump@whitehouse.gov'),
//        ('President Yeezy', 'yeezus@kanyewest.com');
//      """)
//    let users = try? database.execute(complexQuery: "SELECT * from users")
//    for user in users! {
//      print(user)
//    }
  }
}

