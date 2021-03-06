      SUBROUTINE MBMODE(INPUT,OUT,ICOR,NCOR,Z,NI,ND,XD,YD,IS,CR)
C
C     MBMODE BUILDS THE MODE LIKE DATA ON OUT FROM SURFACE SPLINE INTER
C
      DIMENSION Z(1),XD(1),YD(1),NAME(2)
      DATA NAME /4HMBMO,4HDE  /
      NNI = NI*2
      NND = ND*2
      IF(ICOR+NNI+NND.GT.NCOR) CALL MESAGE(-8,0,NAME)
      CALL FREAD(INPUT,Z(ICOR),NNI,0)
      IDP = ICOR + NNI
      L = 0
      DO 10 I=1,ND
      Z(IDP+L) = XD(I)
      Z(IDP+L+1) = YD(I)
      L = L+2
   10 CONTINUE
      ICC = IDP+L
      NCORE = NCOR-ICC
C
C     CALL SSPLIN TO INTERPOLATE
C
      CALL SSPLIN(NI,Z(ICOR),ND,Z(IDP),0,0,1,0,0.0,Z(ICC),NCORE,IS)
      IF(IS.EQ.2) GO TO 1000
C
C     REORDER INTO MACH BOX ORDER
C
      M = IDP+ND
      ICC = ICC-1
      DO 30 I=1,NI
      L = 0
      DO 20 J=1,NND,2
      Z(IDP+L) = Z(ICC+J)
      Z(M+L) = Z(ICC+J+1) * CR
      L = L+1
   20 CONTINUE
      CALL WRITE(OUT,Z(IDP),NND,0)
      ICC = ICC + NND
   30 CONTINUE
 1000 RETURN
      END
