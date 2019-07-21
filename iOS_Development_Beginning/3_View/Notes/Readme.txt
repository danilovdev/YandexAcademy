1. ViewController - основной котроллер приложения, в нем лежат все элементы интерфейса

2. ColorPicker - компонент для выбора цвета. Имеет свойства

	selectedColor: UIColor? - хранит текущий цвет

	doneHandler: ((_ selectedColor: UIColor?) -> Void)? - хранит обработчик кнопки Done, в который передает значение выбранного цввет

3. PalleteView - компонент для отображения палитры цветов. Имеет свойства

	func getPointForColor(color: UIColor) -> CGPoint? - возвращает точку для выбранного цвета

    func getColor(at point: CGPoint) -> UIColor? - возвращает цвет для заданной точки
 
    var brightness: CGFloat? - хранит ярокть для выбранного цвета
 
4. ColorSquareView - компонент для отрисовки квадратика с выбранным цветом или квалратика палитры. 
Имеет свойства:

	var isSelected: Bool? - флаг выбран ли квадрат с цветом
    
    private var circlePath: UIBezierPath! - путь для рисования круга
    
    var type: ColorSquareViewType? - тип квадрата (обычный или с палитрой)

