package com.logger;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.logging.FileHandler;
import java.util.logging.Formatter;
import java.util.logging.Handler;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.logging.SimpleFormatter;

public class MyLogger {
	static Logger logger;
	public Handler fileHandler;
	SimpleFormatter plainText;
	    
	public MyLogger() throws IOException{
        //instance the logger
        logger = Logger.getLogger(MyLogger.class.getName());
        //instance the filehandler
        fileHandler = new FileHandler("C:/Users/Winfred Villaluna/Documents/Repository/LibrarySystem/myLog.txt",true);
        //instance formatter, set formatting, and handler
        plainText = new SimpleFormatter();
        fileHandler.setFormatter(plainText);
        logger.addHandler(fileHandler);

    }
	
	private static Logger getLogger(){
	    if(logger == null){
	        try {
	            new MyLogger();
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    }
	    return logger;
	}
	public static void log(Level level, String msg){
	    getLogger().log(level, msg);
	    System.out.println(msg);
	}
}   