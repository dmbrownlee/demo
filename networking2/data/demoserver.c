// This is a modification of the server.c code found on http://www.linuxhowtos.org/C_C++/socket.htm
/* A simple server in the internet domain using TCP
   The port number is passed as an argument */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h> 
#include <sys/socket.h>
#include <netinet/in.h>

void error(const char *msg)
{
    perror(msg);
    exit(1);
}

int main(int argc, char *argv[])
{
     int sockfd, newsockfd, portno;
     socklen_t clilen;
     char buffer[256];
     char reply[34];
     struct sockaddr_in serv_addr, cli_addr;
     int n,m;
     sockfd = socket(AF_INET, SOCK_STREAM, 0);
     if (sockfd < 0) 
        error("ERROR opening socket");
     bzero((char *) &serv_addr, sizeof(serv_addr));
     // Hardcode port number to see if students can find it
     portno = 42515;
     serv_addr.sin_family = AF_INET;
     serv_addr.sin_addr.s_addr = INADDR_ANY;
     serv_addr.sin_port = htons(portno);
     if (bind(sockfd, (struct sockaddr *) &serv_addr,
              sizeof(serv_addr)) < 0) 
              error("ERROR on binding");
     listen(sockfd,5);
     printf("demoserver is running.\n");
     clilen = sizeof(cli_addr);
     // No need for a loop as we will exit after one connection
     newsockfd = accept(sockfd, 
                 (struct sockaddr *) &cli_addr, 
                 &clilen);
     if (newsockfd < 0) error("ERROR on accept");
     bzero(buffer,sizeof(buffer));
     while ((n = read(newsockfd,buffer,sizeof(buffer)-1))> 0) {
       if (n < 0) error("ERROR reading from socket");
       // add artifical delay so we have time to check the queue size
       sleep(2);
       bzero(reply,sizeof(reply));
       n = sprintf(reply, "Server read %d bytes from client\n", n);
       n = write(newsockfd,reply,sizeof(reply));
       if (n < 0) error("ERROR writing to socket");
       bzero(buffer,sizeof(buffer));
     };
     close(newsockfd);
     close(sockfd);
     return 0; 
}
