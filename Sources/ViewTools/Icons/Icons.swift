//
//  File.swift
//
//
//  Created by Dave Coleman on 25/6/2024.
//

import Foundation

// MARK: - Icons
// swift-format-ignore
public enum Icons: String, Codable, Equatable, Sendable, CaseIterable, Identifiable {
  case stats = "chart.dots.scatter"                                 // 􁣃
  case statsAlt = "chart.pie"                                       // 􀑀
  case refresh = "arrow.triangle.2.circlepath"                      // 􀊯
  case trash = "trash"                                              // 􀈑
  case controller = "gamecontroller"                                // 􀛸
  case controllerAlt = "arcade.stick.console"                       // 􂁠
  case plug = "powerplug"                                           // 􀡷
  case powerCord = "powercord"                                      // 􁣷
  case shocked = "poweroutlet.type.b"                               // 􁌾
  case powerAU = "poweroutlet.type.i"                               // 􁍖
  case tap = "spigot"                                               // 􁒾
  case antenna = "antenna.radiowaves.left.and.right"                // 􀖀
  case heart = "heart"                                              // 􀊴
  case game = "sdcard"                                              // 􀪇
  case back = "chevron.backward"                                    // 􀯶
  case forward = "chevron.forward"                                  // 􀯻
  case moon = "moon"                                                // 􀆹
  case up = "chevron.up"                                            // 􀆇
  case down = "chevron.down"                                        // 􀆈

  case sort = "arrow.up.arrow.down"                                 // 􀄬
  case box = "shippingbox"                                          // 􀐚
  case debug = "ladybug"                                            // 􀯔
  case filter = "line.horizontal.3.decrease"                        // 􀜓
  case store = "storefront"                                         // 􁽇
  case source = "square.and.arrow.down"                             // 􀈄
  case sourceAlt = "water.waves.and.arrow.trianglehead.down"
  case person = "person"                                            // 􀉩
  case menu = "line.3.horizontal.decrease"                          // 􀜓
  case question = "questionmark.circle"                             // 􀁜
  case questionAlt = "questionmark"                                 // 􀅍
  case thumb = "hand.thumbsup"                                      // 􀉿
  case grid = "rectangle.grid.3x2"                                  // 􀇶
  case gridAlt = "square.grid.2x2"                                  // 􀇷
  case dimensions = "arrow.down.left.and.arrow.up.right.rectangle"
  case pin = "pin"                                                  // 􀎦
  case portrait = "rectangle.portrait"                              // 􀟏
  case plus = "plus"                                                // 􀅼
  case plusSquare = "plus.app"                                      // 􀑍
  case `import` = "tray.and.arrow.down.fill"                        // 􀈨
  case warning = "exclamationmark.triangle.fill"                    // 􀇿
  case share = "square.and.arrow.up"                                // 􀈂
  case info = "info.circle"                                         // 􀅴
  case inspector = "rectangle.rightthird.inset.filled"              // 􀨩
  case popup = "text.bubble"                                        // 􀌲
  case message = "bubble"                                           // 􂄹
  case messageAlt = "bubble.middle.bottom"                          // 􀌸
  case image = "photo"                                              // 􀏅
  case imageMulti = "photo.on.rectangle.angled"                     // 􀣵
  case options = "slider.horizontal.3"                              // 􀌆
  case gear = "gearshape"                                           // 􀣋
  case glasses = "eyeglasses"                                       // 􀖆
  case bookmark = "bookmark"                                        // 􀉞
  case rays = "rays"                                                // 􀇯
  case rotate = "arrow.counterclockwise"                            // 􀅉
  case window = "macwindow"                                         // 􀏜
  case pause = "pause"                                              // 􀊅
  case stop = "stop"                                                // 􀛶
  case stopAlt = "octagon"                                          // 􀟊
  case clock = "clock"                                              // 􀐫
  case tick = "checkmark"                                           // 􀆅
  case gift = "gift"                                                // 􀑉
  case giftAlt = "app.gift"                                         // 􀑑
  case eye = "eye"                                                  // 􀋭
  case title = "textformat"                                         // 􀅒
  case cloud = "cloud"                                              // 􀇂
  case circle = "circle"                                            // 􀀀
  case binoculars = "binoculars"                                    // 􀠍
  case hashtag = "number"                                           // 􀆃
  case hashtagAlt = "grid"                                          // 􀓗
  case sidebar = "sidebar.left"                                     // 􀏚
  case sidebarAlt = "rectangle.leftthird.inset.filled"              // 􀨱
  case list = "square.stack"                                        // 􀐋
  case drag = "line.3.horizontal"                                   // 􀌇
  case library = "books.vertical"                                   // 􀬒
  case trophy = "trophy"                                            // 􀠏
  case globe = "globe.asia.australia"                               // 􀵵
  case userInterface = "slider.horizontal.below.rectangle"          // 􀐗
  case cross = "xmark"                                              // 􀆄
  case crossSquare = "x.square"                                     // 􀃂
  case swirl = "glowplug"                                           // 􁀱
  case dismissKeyboard = "keyboard.chevron.compact.down"            // 􀓖
  case go = "arrow.up.right"                                        // 􀄯
  case goAlt = "arrow.forward"                                      // 􀰑
  case sparkle = "sparkles"                                         // 􀆿
  case empty = "light.max"                                          // 􀇮
  case waveGraph = "graph.2d"
  case search = "magnifyingglass"                                   // 􀊫
  case zoomCircle = "magnifyingglass.circle.fill"                   // 􀒓
  case pan = "rectangle.and.hand.point.up.left"                     // 􀪤
  case home = "house"                                               // 􀎞
  case gesture = "hand.pinch"
  case folder = "folder"                                            // 􀈕
  case waves = "waveform"                                           // 􀙫
  case escape = "escape"                                            // 􀆧
  case sparkles = "bubbles.and.sparkles"                            // 􁒉
  case calendar = "calendar"                                        // 􀉉
  case text = "text.alignleft"                                      // 􀌀
  case background = "rectangle.tophalf.inset.filled"                // 􀾮
  case trackpad = "rectangle.and.hand.point.up.left.filled"         // 􀪧
  case screenshot = "rectangle.on.rectangle.angled"                 // 􀑯
  case screenshotAlt = "squares.below.rectangle"                    // 􀏡
  case edit = "square.and.pencil"                                   // 􀈎
  case blurb = "quote.bubble"                                       // 􀌮
  case gradient = "water.waves"                                     // 􁎄
  case copy = "square.on.square"                                    // 􀐅
  case copyAlt = "doc.on.doc"                                       // 􀉁
  case command = "command"                                          // 􀆔
  case select = "character.cursor.ibeam"                            // 􀅫
  case door = "door.left.hand.open"                                 // 􁏜
  case expand = "arrow.down.left.and.arrow.up.right"                // 􂄝
  case toolbar = "rectangle.topthird.inset.filled"                  // 􀴊
  case logOut = "rectangle.portrait.and.arrow.right"                // 􀻵
  case developer = "keyboard"                                       // 􀇳
  case token = "hockey.puck"                                        // 􁛽
  case newWindow = "macwindow.on.rectangle"                         // 􀢌
  case sliders = "switch.2"                                         // 􀜊
  case minus = "minus"                                              // 􀅽
  case qrCode = "qrcode"                                            // 􀖂
  case fish = "fish"                                                // 􁖐
  case hanger = "hanger"                                            // 􀠖
  case sport = "figure.basketball"                                  // 􁔛
  case paperclip = "paperclip"                                      // 􀉢
  case pentagon = "pentagon"                                        // 􀶺
  case bitmap = "stairs"                                            // 􁕋
  case theatre = "theatermasks"                                     // 􀺧
  case boat = "ferry"                                               // 􀸅
  case star = "star"                                                // 􀋂
  case ellipsis = "ellipsis"                                        // 􀍠
  case highlighter = "highlighter"                                  // 􀦇
  case key = "key"                                                  // 􀟕
  case snowflake = "snowflake"                                      // 􀇥
  case contrast = "circle.lefthalf.striped.horizontal.inverse"      // 􁹦
  case contrastAlt = "circle.lefthalf.filled.inverse"               // 􁹭
  case horn = "horn"                                                // 􁄵
  case hornBlast = "horn.blast"                                     // 􁄷
  case palette = "paintpalette"                                     // 􀝥
  case plane = "paperplane"                                         // 􀈟
  case lock = "lock"                                                // 􀎠
  case scribble = "scribble.variable"                               // 􀤑
  case scribbleMono = "scribble"                                    // 􀓨
  case wordCount = "text.word.spacing"                              // 􀵫
  case layers = "square.2.layers.3d"                                // 􀯭
  case moreLayers = "square.3.layers.3d"                            // 􀯰
  case cursor = "cursorarrow"                                       // 􀫌
  case character = "character.square"
  case arrowUp = "arrow.up"                                         // 􀄨
  case arrowDown = "arrow.down"                                     // 􀄩
  case next = "arrow.right"                                         // 􀄫
  case previous = "arrow.left"                                      // 􀄪
  case tag = "tag"                                                  // 􀋡
  case rpg = "text.book.closed"                                     // 􀫗
  case survival = "backpack"                                        // 􁋹
  case multiplayer = "person.3"                                     // 􀝊
  case racing = "flag.checkered"                                    // 􁙌
  case action = "burst"                                             // 􀑂

  public var id: String { self.rawValue }

  public var icon: String {
    return self.rawValue
  }

  public var reference: String {
    return self.rawValue
  }

  public static var getRandom: Self {
    return Icons.allCases.randomElement() ?? Icons.action
  }
}

// MARK: - Convenience aliases
extension Icons {

  public static let app = Self.window
  public static let canvas = Self.dimensions
  public static let export = Self.share
  public static let paragraph = Self.wordCount
  public static let pixels = Self.bitmap
  public static let pointer = Self.cursor
  public static let raster = Self.bitmap
  public static let size = Self.dimensions
  public static let viewport = Self.window
  public static let zoom = Self.search

}
