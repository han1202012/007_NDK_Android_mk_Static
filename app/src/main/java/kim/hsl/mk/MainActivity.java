package kim.hsl.mk;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    static {

        // 1 . 加载动态库的情况 : ( 必须不能注释下面的代码 )
        //      ① 6.0 以下的版本 : 需要手动加载依赖库 libadd.so
        //      ② 6.0 以上的版本 : 无法使用 Android.mk 构建脚本加载第三方动态库
        //                         此情况下, 无论是否手动加载 libadd.so 都会报错
        //
        // 2 . 加载静态库的情况 : ( 必须注释掉下面的这行代码 )
        //      此处注释掉
        //System.loadLibrary("add");

        System.loadLibrary("native-lib");
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        TextView tv = findViewById(R.id.sample_text);
        tv.setText(stringFromJNI());
    }

    public native String stringFromJNI();
}
