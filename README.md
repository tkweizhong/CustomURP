# CustomURP
customed unity universal renderer pipeline 

知乎： https://zhuanlan.zhihu.com/p/366151503

这是一个定制的URP的Demo。实际用到游戏中还需要根据各自游戏进行修改。

本方案主要实现以下内容：

1，场景相机走Linear渲染; UI相机走Gamma渲染

2，场景相机和ui相机分辨率分离

3，修正FXAA在最后pass渲染，导致UI模糊问题