A Prototype to Demo our New Project for IRIS
Assume that the procurement of item “x” requires a follow-up of two documents (A, B). However, the first (A) and
second (B) documents require the approval of participants P, Q, R, and S.
Buyer (U) initiates document A. First, approval by P, followed by Q & R, and finally S. The same is also for the
second document B.
Database (Table):
1. User:
User_ID; User_Name; Password
Note: Use username names are U, P, Q, R, S
2. Doc_A:
Eq_ID (A1); Name (A2) Cost (A3); Head (A4); U_Date (A5); U_Remarks (A6); P_Date (A7); P_Remarks (A8);
Q_Date (A9); Q_Remarks (A10); R_Date (A11); R_Remarks (A12); S_Date (A13); S_Remarks (A14)
Eq_ID (A1) → Equipment ID prefixed by “CSE_<1, 2, 3…>
Name (A2) → Equipment name, such as “Desktop”, “Printer”, etc.
Cost (A3) → Cost of the equipment
Head (A4) → Head of the purchase, such as “OPC”, “IRG”, “Project”
<U/P/Q/R/S>_Date (A5, A7, A9, A11, A13) → Date of processing by user U/P/Q/R/S
<U/P/Q/R/S>_Remarks (A6, A8, A10, A12, A14) → Remarks filled by the user U/P/Q/R/S at the time of processing
Note: Document “A” initiated by the user U and fills A1, A2, A3, and A4. User U forwards this to user P (by clicking
the forward button) with the remark A6. However, A5 is auto-filled based on the date of forwarding to P. User P, after
the login, sees the forwarded details by user U and updates the remark (A8), and A7 will be auto-filled before the
same gets forwarded to Q & S. After the Q & S remarks (A10 and A12), the same will be forwarded to the user S.
After the user S remarks (A14), it is the completion of the document A approval and the software proceed to
document B.
3. Doc_B:
Eq_ID (A1); Name (A2) Cost (A3); Head (A4); Proceedings (B1); U_Date (B2); U_Remarks (B3); P_Date (B4);
P_Remarks (B5); Q_Date (B6); Q_Remarks (b7); R_Date (B8); R_Remarks (B9); S_Date (B10); S_Remarks (B11)
A1, A2, A3, A4 → Auto-filled after the completion of document A and before processing of document B by the user
U.
Proceeding (B1) → Some comments
B2 .. B11 → Same as document A’s A5 .. A14
Note: During the procurement process of item “x” and its processing of the documents A & B, users should be able
to track the status.