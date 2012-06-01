class CrashController < UIViewController
  def viewDidLoad
    @crashButton = add_button("Crash Me", 100, 30)
    @crashButton.addTarget(
      self, action:'crash_button', forControlEvents:UIControlEventTouchUpInside)
    view.addSubview(@crashButton)

    @goodButton = add_button("Good Button", 200, 30)
    @goodButton.addTarget(
      self, action:'good_button', forControlEvents:UIControlEventTouchUpInside)
    view.addSubview(@goodButton)

    @noDispatchButton = add_button("No Dispatch Queue", 300, 30)
    @noDispatchButton.addTarget(
      self, action:'no_dispatch_button', forControlEvents:UIControlEventTouchUpInside)
    view.addSubview(@noDispatchButton)
  end

  def add_button(text, y, height)
    button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    button.setTitle(text, forState:UIControlStateNormal)
    button.frame = 
      [[20, y], [view.frame.size.width - 20 * 2, height]]
    view.addSubview(button)
    button
  end

  def crash_button
    p "Crash Button pushed"

    google = "http://www.google.com"
    Dispatch::Queue.concurrent.async do
      error_ptr = Pointer.new(:object)
      data = NSData.alloc.initWithContentsOfURL(
        NSURL.URLWithString(google))
      unless data
        p error_ptr[0]
        return
      end
      Dispatch::Queue.main.sync { print_results(data) }
    end
  end

  def good_button
    p "Good Button pushed"

    Dispatch::Queue.concurrent.async do
      error_ptr = Pointer.new(:object)
      data = NSData.alloc.initWithContentsOfURL(
        NSURL.URLWithString("http://www.google.com"))
      unless data
        p error_ptr[0]
        return
      end
      Dispatch::Queue.main.sync { print_results(data) }
    end
  end

  def no_dispatch_button
    p "No Dispatch Queue Button pushed"

    url = "http://www.google.com"
    data = NSData.alloc.initWithContentsOfURL(
      NSURL.URLWithString(url))
    print_results(data) 
  end

  def print_results(data)
    puts data
  end
end
