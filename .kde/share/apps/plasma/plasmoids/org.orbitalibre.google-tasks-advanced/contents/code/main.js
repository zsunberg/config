/*
Copyright © 2011 David Palacio <dpalacio@orbitalibre.org>

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU Library General Public License as
published by the Free Software Foundation; either version 2 or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details

You should have received a copy of the GNU Library General Public
License along with this program; if not, write to the
Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*/

var createBrush = function(color) {
  var pen = new QPen()
  pen.color = QColor(color)
  return pen.brush
}

var brush = createBrush("white")

var isPopup = false

plasmoid.paintInterface = function(painter) {
  if(!isPopup) {
    painter.fillRect(plasmoid.rect, brush)
  }
}

plasmoid.formFactorChanged = function() {
  isPopup = plasmoid.formFactor == Vertical ||
            plasmoid.formFactor == Horizontal
}

var loadFinished = function(success) {
  if(success) {
    plasmoid.busy = false
    timeout.stop()
  } else {
    timeout.stop()
    retry()
  }
}

var view = new WebView()
view.url = Url("https://mail.google.com/tasks/canvas")
view.minimumSize = QSizeF(100,100)
view.loadFinished.connect(loadFinished)

plasmoid.popupIcon = new QIcon(plasmoid.file("images", "view-calendar-tasks.png"))
plasmoid.setMinimumSize = QSizeF(100,100)
plasmoid.aspectRatioMode = IgnoreAspectRatio
plasmoid.backgroundHints = NoBackground //TranslucentBackground
plasmoid.popupWidget = view
plasmoid.busy = true

var retry = function() {
  plasmoid.busy = false
  view.url = Url(plasmoid.file("data", "retry.html"))
}
var timeout = new QTimer()
timeout.singleShot = true
timeout.timeout.connect(retry)
timeout.start(60000) //Show retry message in 1 minute.

