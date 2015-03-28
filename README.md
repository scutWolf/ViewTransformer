ViewTransformer
===================================  

1.Import first
-----------------------------------  
import "ViewTransformer.h"

2.Init the view transformer with add icon image 
-----------------------------------  
###
    @property (strong, nonatomic) ViewTransformer *viewTransformer;
###
    -(ViewTransformer *)viewTransformer {

        if (!_viewTransformer) {

           _viewTransformer = [[ViewTransformer alloc]initWithIconImage:[UIImage imageNamed:@"addIcon"]];
           [self.view addSubview:_viewTransformer];
        }
        return _viewTransformer;
    }

3.Set the view to transform:
-----------------------------------  
###
    self.viewTransformer.targetView = targetView;

4.To remove the focus :
-----------------------------------  
###
    self.viewTransformer.targetView = nil;

5.To correct the point of the viewTransformer when the targetView moving or moved:
-----------------------------------  
###
    [self.viewTransformer correctTransformerPoint];
    
6.You can set the border color or border width:
-----------------------------------  
###
    self.viewTransformer.borderColor = [UIColor greenColor];
    self.viewTransformer.borderWidth = 2.0;
