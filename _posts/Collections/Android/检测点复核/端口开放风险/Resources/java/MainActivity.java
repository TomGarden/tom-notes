package com.example.scanopenport;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

import java.util.ArrayList;

/**
 * 扫描 Android 开放端口，需要 root
 */
public class MainActivity extends AppCompatActivity implements View.OnClickListener {

    private final String TAG = "MainActivity";
    private CommandExecute.CommandResult commandResultNetstat;
    private ArrayList<String> protrol_port;
    private String uids;

    private TextView tvState;
    private EditText etResult;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        this.initView();
    }

    private void initView() {
        findViewById(R.id.btn_netstat).setOnClickListener(this);
        findViewById(R.id.btn_getProctrolPort).setOnClickListener(this);
        findViewById(R.id.btn_getUID).setOnClickListener(this);
        findViewById(R.id.btn_application).setOnClickListener(this);

        this.tvState = findViewById(R.id.tv_state);
        this.etResult = findViewById(R.id.tv_result);
    }

    @Override
    public void onClick(View view) {
        this.tvState.setText("Doing……");
        switch (view.getId()) {
            case R.id.btn_netstat:
                this.execNetstat();
                break;
            case R.id.btn_getProctrolPort:
                this.getProctrolPort();
                //this.getHexadecimalPort();
                break;
            case R.id.btn_getUID:
                this.getUID();
                break;
            case R.id.btn_application:
                this.getApp();
                break;
        }
        this.tvState.setText("Done");
    }

    private void execNetstat() {
        String cmd = "netstat -nautw | grep -E \"LISTEN|ESTABLISHED|SYN_SENT|SYN_RECV\"";
        LogUtil.e(LogUtil.msg() + cmd);
        this.commandResultNetstat = CommandExecute.execCommand(cmd, false);

        String result = this.etResult.getText().toString();
        this.etResult.setText(this.commandResultNetstat.successMsg +
                "\n\n*************************************\n\n" + result);

    }

    //废弃
    private void getHexadecimalPort() {
        if (this.commandResultNetstat == null) {
            LogUtil.e(LogUtil.msg() + "netstat 命令尚未执行");
            return;
        } else if (this.commandResultNetstat.result != 0) {
            LogUtil.e(LogUtil.msg() + "netstat 命令执行有异常");
            return;
        }

        String[] proctrols = this.commandResultNetstat.successMsg.split("\n");
        StringBuffer localeAddress = new StringBuffer();
        StringBuffer portsBuffer = new StringBuffer();
        ArrayList<Integer> ports = new ArrayList<>();
        for (String value : proctrols) {
            //Locale Address
            String[] contentPorts = value.split("\\s+");
            localeAddress.append(contentPorts[3]);
            localeAddress.append("\n");

            //Ports
            String[] splitAddress = contentPorts[3].split(":");
            portsBuffer.append(splitAddress[splitAddress.length - 1]);
            ports.add(Integer.parseInt(splitAddress[splitAddress.length - 1]));
        }

        for (int value : ports) {
            String port = String.format("%d\t%x", value, value);
            LogUtil.i(LogUtil.msg() + port);
        }

    }

    private void getProctrolPort() {
        if (this.commandResultNetstat == null) {
            LogUtil.e(LogUtil.msg() + "netstat 命令尚未执行");
            return;
        } else if (this.commandResultNetstat.result != 0) {
            LogUtil.e(LogUtil.msg() + "netstat 命令执行有异常");
            return;
        }

        String[] proctrols = this.commandResultNetstat.successMsg.split("\n");
        this.protrol_port = new ArrayList<>();
        for (String value : proctrols) {
            //拿到协议
            String[] contentPorts = value.split("\\s+");
            String protrolProt = contentPorts[0];
            //拿到十六进制端口
            String[] splitAddress = contentPorts[3].split(":");
            String decimalPort = splitAddress[splitAddress.length - 1];
            String hexadecimalPort = String.format("%X", Integer.parseInt(decimalPort));
            //拼装协议和端口
            protrolProt += ("_" + hexadecimalPort);
            //添加
            protrol_port.add(protrolProt);
        }
        LogUtil.i(LogUtil.msg() + "portrolPort获取完成");

        String result = this.etResult.getText().toString();
    }

    private void getUID() {
        if (this.protrol_port == null || this.protrol_port.size() == 0) {
            LogUtil.e(LogUtil.msg() + "netstat 命令为获取到端口");
            return;
        }
        StringBuffer uidBuffer = new StringBuffer();
        for (String value : this.protrol_port) {
            String[] protrolPort = value.split("_");

            String cmd = "";
            String cmd6 = "";
            if (protrolPort[0].contains("tcp")) {
                cmd = String.format("grep -i %s /proc/net/%s | cut -b 35-81", protrolPort[1], protrolPort[0]);
                cmd6 = String.format("grep -i %s /proc/net/%s6 | cut -b 83-129", protrolPort[1], protrolPort[0]);
            } else if (protrolPort[0].contains("udp")) {
                cmd = String.format("grep -i %s /proc/net/%s | cut -b 36-82", protrolPort[1], protrolPort[0]);
                cmd6 = String.format("grep -i %s /proc/net/%s6 | cut -b 84-130", protrolPort[1], protrolPort[0]);
            }

            //String cmd = String.format("cat /proc/net/%s | grep -i %s  | cut -b 35-81", protrolPort[0], protrolPort[1]);
            //String cmd6 = String.format("cat /proc/net/%s | grep -i %s  | cut -b 83-129", protrolPort[0], protrolPort[1]);

            //LogUtil.e(LogUtil.msg() + value);
            //LogUtil.e(LogUtil.msg() + cmd);
            //LogUtil.e(LogUtil.msg() + cmd6);

            String contentUID = "";

            CommandExecute.CommandResult commandResult = CommandExecute.execCommand(cmd, false);
            CommandExecute.CommandResult commandResult6 = CommandExecute.execCommand(cmd6, false);

            if (commandResult.successMsg.length() > 0) {
                contentUID = commandResult.successMsg;
            } else if (commandResult6.successMsg.length() > 0) {
                contentUID = commandResult6.successMsg;
            } else {
                LogUtil.i(LogUtil.msg() + "未知情况请检查");
            }

//            if (commandResult.result == 0 && commandResult6.result == 0) {
//                LogUtil.i(LogUtil.msg() + "未知错误情况请检查 all == 0");
//                LogUtil.w(LogUtil.msg() + commandResult.successMsg);
//                LogUtil.w(LogUtil.msg() + commandResult6.successMsg);
//                continue;
//            } else if (commandResult.result != 0 && commandResult6.result != 0) {
//                LogUtil.i(LogUtil.msg() + "未知错误情况请检查 all != 0");
//                LogUtil.w(LogUtil.msg() + commandResult.errorMsg);
//                LogUtil.w(LogUtil.msg() + commandResult6.errorMsg);
//                continue;
//            } else if (commandResult.result == 0) {
//                //LogUtil.i(LogUtil.msg() + commandResult.successMsg);
//                contentUID = commandResult.successMsg;
//            } else if (commandResult6.result == 0) {
//                //LogUtil.i(LogUtil.msg() + commandResult6.successMsg);
//                contentUID = commandResult6.successMsg;
//            }
            if (!contentUID.isEmpty()) {
                String[] array = contentUID.split("\\s+");
                //LogUtil.i(LogUtil.msg() + contentUID);
                String uid = String.format("u%c_%c%s"
                        , array[0].charAt(0)
                        , array[0].charAt(1)
                        , array[array.length - 1].substring(array[array.length - 1].lastIndexOf('0') + 1));
                if (!uidBuffer.toString().contains("uid")) {
                    uidBuffer.append(uid);
                    uidBuffer.append('|');
                }
            }
        }
        if (uidBuffer.length() > 0) {
            this.uids = uidBuffer.substring(0, uidBuffer.length() - 1);
        }
        LogUtil.i(LogUtil.msg() + uids);

        String result = this.etResult.getText().toString();
        this.etResult.setText(this.uids + "\n\n*************************************\n\n" + result);
    }

    private void getApp() {
        String cmd = String.format("ps | grep -i -E \"%s\"", this.uids);
        LogUtil.e(LogUtil.msg() + cmd);
        CommandExecute.CommandResult commandResult = CommandExecute.execCommand(cmd, false);
        LogUtil.e(LogUtil.msg() + "\n" + commandResult.successMsg);

        StringBuffer applications = new StringBuffer();
        String[] applicitionWith = commandResult.successMsg.split("\n");
        for (String value : applicitionWith) {
            String[] application = value.split("\\s+");
            applications.append(application[application.length - 1]);
            applications.append('\n');
        }

        LogUtil.e(LogUtil.msg() + "\n" + applications.toString());

        String result = this.etResult.getText().toString();
        this.etResult.setText(applications.toString() + "\n\n*************************************\n\n" + result);
    }
}