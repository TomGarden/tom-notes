package com.example.scanopenport;

/**
 * Created by tom on 17-12-20.
 */


import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;

/**
 * 执行shell脚本工具类
 *
 * @author Mountain
 */
public class CommandExecute {

    public static final String TAG = "CommandExecution";

    public final static String COMMAND_SU = "su";
    public final static String COMMAND_SH = "sh";
    public final static String COMMAND_EXIT = "exit\n";
    public final static String COMMAND_LINE_END = "\n";

    /**
     * Command执行结果
     *
     * @author Mountain
     */
    public static class CommandResult {
        public int result = -1;
        public String errorMsg;
        public String successMsg;
    }

    /**
     * 执行命令—单条
     *
     * @param command
     * @param isRoot
     * @return
     */
    public static CommandResult execCommand(String command, boolean isRoot) {
        String[] commands = {command};
        return execCommand(commands, isRoot);
    }

    /**
     * 执行命令-多条
     *
     * @param commands
     * @param isRoot
     * @return
     */
    public static CommandResult execCommand(String[] commands, boolean isRoot) {
        CommandResult commandResult = new CommandResult();
        if (commands == null || commands.length == 0) {
            return commandResult;
        }

        Process process = null;
        DataOutputStream dataOutputStream = null;
        BufferedReader successResult = null;
        BufferedReader errorResult = null;
        StringBuilder successMsg = null;
        StringBuilder errorMsg = null;

        try {
            process = Runtime.getRuntime().exec(isRoot ? COMMAND_SU : COMMAND_SH);
            dataOutputStream = new DataOutputStream(process.getOutputStream());
            for (String command : commands) {
                if (command != null) {
                    dataOutputStream.write(command.getBytes());
                    dataOutputStream.writeBytes(COMMAND_LINE_END);
                    dataOutputStream.flush();
                }
            }
            dataOutputStream.writeBytes(COMMAND_EXIT);
            dataOutputStream.flush();
            commandResult.result = process.waitFor();
            //获取错误信息
            successMsg = new StringBuilder();
            errorMsg = new StringBuilder();
            successResult = new BufferedReader(new InputStreamReader(process.getInputStream()));
            errorResult = new BufferedReader(new InputStreamReader(process.getErrorStream()));
            String s;
            while ((s = successResult.readLine()) != null) {
                successMsg.append(s);
                successMsg.append('\n');
            }
            while ((s = errorResult.readLine()) != null) {
                errorMsg.append(s);
                errorMsg.append('\n');
            }
            commandResult.successMsg = successMsg.toString();
            commandResult.errorMsg = errorMsg.toString();

//            LogUtil.i(LogUtil.msg() + "commandResult.resultCode = " + commandResult.result);
//            LogUtil.d(LogUtil.msg() +"commandResult.successMsg\n" + commandResult.successMsg);
//            LogUtil.e(LogUtil.msg() +"commandResult.errorMsg\n" + commandResult.errorMsg);
        } catch (IOException e) {
            String errmsg = e.getMessage();
            if (errmsg != null) {
                LogUtil.e(LogUtil.msg() +errmsg);
            } else {
                e.printStackTrace();
            }
        } catch (Exception e) {
            String errmsg = e.getMessage();
            if (errmsg != null) {
                LogUtil.e(LogUtil.msg() +errmsg);
            } else {
                e.printStackTrace();
            }
        } finally {
            try {
                if (dataOutputStream != null) dataOutputStream.close();
                if (successResult != null) successResult.close();
                if (errorResult != null) errorResult.close();
            } catch (IOException e) {
                String errmsg = e.getMessage();
                if (errmsg != null) {
                    LogUtil.e(LogUtil.msg() +errmsg);
                } else {
                    e.printStackTrace();
                }
            }
            if (process != null) process.destroy();
        }
        return commandResult;
    }

}
