/*
plasmoid.dataUpdated = function(source, data) {
  if(data['exit code'] == 0) {
    label.text = data.stdout
  } else {
    label.text = data.stderr
  }
}
*/

/*
plasmoid.configChanged = function() {
  directory = plasmoid.readConfig("directory")
  period = plasmoid.readConfig("update_period") * 60000
  dataEngine("executable").connectSource(currentSource, plasmoid, period)
}
*/

var createBrush = function(color) {
  pen = new QPen()
  pen.color = QColor(color)
  return pen.brush
}

var brush = createBrush("white")

plasmoid.paintInterface = function(painter) {
  painter.fillRect(plasmoid.rect, brush)
}

plasmoid.aspectRatioMode = IgnoreAspectRatio
plasmoid.backgroundHints = NoBackground //TranslucentBackground
var layout = new LinearLayout(plasmoid)

var view = new WebView()
layout.addItem(view)
//KDE 4.4.5/Qt 4.6.3 bug workaround
if(plasmoid.apiVersion==1) {
  var label = new Label()
  layout.addItem(label)
}
view.url = Url("https://mail.google.com/tasks/ig")

var loadFinished = function() {
  plasmoid.busy = false
}

plasmoid.busy = true
view.loadFinished.connect(loadFinished)

